
RailsAdmin.config do |config|

  ### Popular gems integration

  ## == Devise ==
  config.authenticate_with do
    warden.authenticate! scope: :user
  end
  config.current_user_method(&:current_user)

  ## == Cancan ==
  # config.authorize_with :cancan
  config.authorize_with do
    unless current_user.admin?
      flash[:danger] = "You do not have access to the Admin page"
      redirect_to main_app.root_path
    end
  end

  ## == PaperTrail ==
  # config.audit_with :paper_trail, 'User', 'PaperTrail::Version' # PaperTrail >= 3.0.0

  ### More at https://github.com/sferik/rails_admin/wiki/Base-configuration

  config.actions do
    dashboard                     # mandatory
    index                         # mandatory
    new
    export
    bulk_delete
    show
    edit
    delete
    show_in_app

    ## With an audit adapter, you can add:
    # history_index
    # history_show
  end

  config.model 'LiveClass' do
    edit do
      field :subject
      field :professor
      field :url
      field :online_now

      field :time do
        strftime_format "%Y-%m-%d %H:%M"
      end
      field :explanation
    end
  end

  config.model SimulatedCategory do
    edit do
      field :category, :belongs_to_association
    end
  end

  config.label_methods.unshift(:rails_admin_displayed_label)
  config.model Point do
    edit do
      field :point_action, :belongs_to_association
      field :points
      field :recipient_type
      field :recipient_id
      field :owner_id, :hidden do
        default_value do
          bindings[:view]._current_user.id
        end
      end
      field :owner_type, :hidden do
        default_value do
          'User'
        end
      end
    end
  end
end
