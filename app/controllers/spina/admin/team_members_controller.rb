module Spina
  module Admin
    class TeamMembersController < AdminController
      before_action :set_team_member, only: %i[edit update destroy]

      admin_section :team_members

      def index
        @team_members = Spina::TeamMember.sorted
      end

      def new
        @team_member = Spina::TeamMember.new
      end

      def create
        @team_member = Spina::TeamMember.new(team_member_params)
        if @team_member.save
          redirect_to spina.edit_admin_team_member_path(@team_member), notice: 'Team member saved.'
        else
          render :new, status: :unprocessable_entity
        end
      end

      def edit; end

      def update
        if @team_member.update(team_member_params)
          redirect_to spina.edit_admin_team_member_path(@team_member), notice: 'Team member saved.'
        else
          render :edit, status: :unprocessable_entity
        end
      end

      def destroy
        @team_member.destroy
        redirect_to spina.admin_team_members_path
      end

      def sort
        params[:ids].each.with_index do |id, index|
          Spina::TeamMember.where(id: id).update_all(position: index + 1)
        end

        flash.now[:info] = 'Order saved.'
        render_flash
      end

      private

      def set_team_member
        @team_member = Spina::TeamMember.find(params[:id])
      end

      def team_member_params
        params.require(:team_member).permit(
          :firstname, :middlename, :lastname, :role, :description,
          :photo_id, :twitter, :linkedin, :show_on_homepage
        )
      end
    end
  end
end
