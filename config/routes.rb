Osem::Application.routes.draw do

  if ENV['OSEM_ICHAIN_ENABLED'] == 'true'
    devise_for :users, controllers: { registrations: :registrations }
  else
    devise_for :users,
               controllers: {
                   registrations: :registrations, confirmations: :confirmations,
               },
               path: 'accounts'
    namespace "passwordless" do
      devise_for :users,
        controllers: { sessions: "devise/passwordless/sessions" }
    end
  end

  # Use letter_opener_web to open mails in browser (e.g. necessary for Vagrant)
  if Rails.env.development?
    mount LetterOpenerWeb::Engine, at: "/letter_opener"
  end

  # custom error pages for production mode
  if Rails.env.production?
    match "/404", :to => "errors#not_found", :via => :all
    match "/500", :to => "errors#internal_server_error", :via => :all
  end

  resources :users, except: [:new, :index, :create, :destroy]

  namespace :portal do
    resources :sponsors, except: [:new, :create, :destroy] do
      resources :conferences, except: [:new, :create, :destroy] do
        resources :codes, only: [:show]
        resources :benefit_responses
      end
    end
  end

  namespace :admin do
    resources :users
    resources :users do
      member do
        patch :toggle_confirmation
      end
    end
    namespace :reports do
      get '/visits' => 'visits#index'
      post '/visits' => 'visits#index'
    end
    resources :conference_groups
    resources :sponsors
    resources :comments, only: [:index]
    resources :conferences do
      resource :contact, except: [:index, :new, :create, :show, :destroy]
      resources :schedules, except: [:new] do
        collection do
          patch :sync_all
        end
      end
      resources :event_schedules, only: [:create, :update, :destroy]
      get 'commercials/render_commercial' => 'commercials#render_commercial'
      resources :commercials, only: [:index, :create, :update, :destroy]
      get '/volunteers_list' => 'volunteers#show'
      get '/volunteers' => 'volunteers#index', as: 'volunteers_info'
      patch '/volunteers' => 'volunteers#update', as: 'volunteers_update'
      get '/archive' => 'conferences#archive'
      get '/unarchive' => 'conferences#unarchive'
      resources :registrations, except: [:create, :new] do
        member do
          patch :toggle_attendance
        end
        collection do
          patch :sync_all
        end
      end

      # Singletons
      resource :splashpage
      resource :venue do
        get 'venue_commercial/render_commercial' => 'venue_commercials#render_commercial'
        resource :venue_commercial, only: [:create, :update, :destroy]
        resources :rooms, except: [:show]
	      resources :room_locations, except: [:show]
      end
      resource :registration_period
      resource :sponsorship_info
      resource :payment_method
      resource :poll do
        resource :survey
      end
      resource :program do
        resource :cfp
        resources :tracks
        resources :event_types
        resources :difficulty_levels
        resources :speakers, only: [:index, :update]
        resources :events do
          member do
            patch :toggle_attendance
            get :registrations
            get :attendees
            post :comment
            patch :accept
            patch :accept_and_confirm
            patch :confirm
            patch :cancel
            patch :reject
            patch :unconfirm
            patch :restart
            get :vote
          end
          collection do
            get 'tagged_with/:tag' => 'events#index', as: 'tagged'
            get 'with_track/:track' => 'events#index', as: 'with_track'
            get 'with_type/:type' => 'events#index', as: 'with_type'
            get 'with_difficulty/:difficulty' => 'events#index', as: 'with_difficulty'
            get 'with_state/:state' => 'events#index', as: 'with_state'
            post :bulk_state_change
          end
        end
      end

      resources :tickets do
        member do
          patch :up
          patch :down
        end
      end
      resources :sponsorships, except: [:show]
      resources :lodgings, except: [:show]
      resources :activities, except: [:show]
      resources :advantages, except: [:show]
      resources :benefits, except: [:show]
      resources :boomset_ticket_configs, except: [:show]
      resources :integrations, except: [:show]
      resources :sponsorship_levels_benefits, except: [:show]
      resources :targets, except: [:show]
      resources :campaigns, except: [:show]
      resources :emails, only: [:show, :update, :index]
      resources :roles, except: [ :new, :create ] do
        member do
          post :toggle_user
        end
      end

      resources :conference_team_members, except: [:show, :update] do
        member do
          patch :up
          patch :down
        end
      end

      resources :ticket_groups, except: [:show] do
        member do
          patch :up
          patch :down
        end
      end

      resources :ticket_group_benefits, except: [:show] do
        member do
          patch :up
          patch :down
        end
      end

      resources :sponsorship_levels, except: [:show] do
        member do
          patch :up
          patch :down
        end
      end

      resources :questions do
        collection do
          patch :update_conference
        end
      end

      resources :policies do
        collection do
          patch :update_conference
        end
      end

      resources :codes do
        collection do
          patch :update_conference
        end
      end

      namespace :reports do
        resources :attendees, only: [:index]
        resources :codes, only: [:index]
        resources :duplicate_tickets, only: [:index]
        resources :payments, only: [:index]
        resources :poll_results, only: [:index]
        resources :tickets, only: [:index]
        resources :purchases, only: [:index]
        resources :unregistered_speakers, only: [:index]
      end
    end

    get '/revision_history' => 'versions#index'
    get '/revision_history/:id/revert_object' => 'versions#revert_object', as: 'revision_history_revert_object'
    get '/revision_history/:id/revert_attribute' => 'versions#revert_attribute', as: 'revision_history_revert_attribute'
  end

  resources :conferences, only: [:index, :show] do
    resource :program, only: [] do
      resources :proposals, except: :destroy do
        get 'commercials/render_commercial' => 'commercials#render_commercial'
        resources :commercials, only: [:create, :update, :destroy]
        get 'accept_invitation/:token' => 'proposals#accept_invitation', as: :accept_invitation
        member do
          get :registrations
          patch '/withdraw' => 'proposals#withdraw'
          get :registrations
          patch '/confirm' => 'proposals#confirm'
          patch '/restart' => 'proposals#restart'
          post :comment
          post :invite
          get :vote
        end
      end
    end

    # TODO: change conference_registrations to singular resource
    resource :conference_registration, path: 'register', only: [:show]
    resources :tickets, only: [:index] do
      collection do
        get :complete
      end
    end
    resources :ticket_purchases, only: [:create, :destroy]

    get 'ticket_purchases/recreate' => 'ticket_purchases#recreate'
    get 'ticket_purchases/quickbuy/:event_id' => 'ticket_purchases#quickbuy', as: :event_quickbuy
    resources :payments, only: [:index, :new, :create] do
      collection do
        get :cancel
        get :confirm
      end
    end

    resources :physical_ticket, only: [:index, :show, :update] do
      member do
        get :claim
        patch :assign
      end
    end

    resources :purchases, only: [:index, :show]
    resource :subscriptions, only: [:create, :destroy]
    resource :sponsorships, only: [:show]
    resource :prospectus, only: [:show]
    resource :about, only: [:show], :controller => 'about'
    resource :buytickets, only: [:show], :controller => 'ticket_groups'
    resource :poll do
      resource :attempts, only: [:create, :new, :show]
    end

    resource :schedule, only: [:show] do
      member do
        get :events
        get :today_events
        get :mobile
        get :ical
        get :room
        get :now
        get :today
	      get :sched
      end
    end
  end

  namespace :api, defaults: {format: 'json'} do
    namespace :v1 do
      resources :conferences, only: [ :index, :show ] do
        resources :rooms, only: :index
        resources :tracks, only: :index
        resources :speakers, only: :index
        resources :events, only: :index
        resources :schedule, only: :index
      end
      resources :rooms, only: :index
      resources :tracks, only: :index
      resources :speakers, only: :index
      resources :events, only: :index
    end
  end

  get '/admin' => redirect('/admin/conferences')
  get '/portal' => redirect('/portal/sponsors')

  get '/conferences' => 'conferences#index'
  get '/2017' => 'conferences#show'
  get '/my_proposals' => 'proposals#my_proposals'
  root to: 'refinery/pages#home'
  #root to: 'conferences#redirect_to_current'

  get '/dynamicfields' => redirect('/refinery/dynamicfields')
  mount Refinery::Core::Engine, at: Refinery::Core.mounted_path

end
