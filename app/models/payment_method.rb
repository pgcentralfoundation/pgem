class PaymentMethod < ActiveRecord::Base
  belongs_to :conference

  GATEWAYS = [['Braintree', 'braintree'], ['PayU', 'payu'], ['Stripe', 'stripe']]
  
  BRAINTREE_ENVS = [['Production', 'production'], ['Sandbox', 'sandbox']]

  default_scope { where(environment: Rails.env) }
  
  validates :braintree_environment, inclusion: { in: BRAINTREE_ENVS.map(&:last) }, if: :braintree?
  validates :gateway, inclusion: { in: GATEWAYS.map(&:last) }
  validates :braintree_environment,
            :braintree_merchant_id,
            :braintree_public_key,
            :braintree_private_key,
            :braintree_merchant_account,
            presence: true, if: :braintree?

  validates :payu_store_name,
            :payu_store_id,
            :payu_webservice_name,
            :payu_signature_key,
            :payu_service_domain,
            presence: true, if: :payu?
  
  validates :payu_webservice_password, presence: true, if: [:new_record?, :payu?]
            
  validates :stripe_publishable_key,
            :stripe_secret_key,
            presence: true, if: :stripe?
     
  private
  def braintree?
    self.gateway == 'braintree'
  end
  
  def payu?
    self.gateway == 'payu'
  end
  
  def stripe?
    self.gateway == 'stripe'
  end
end
