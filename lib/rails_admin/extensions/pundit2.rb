require 'rails_admin/extensions/pundit2/authorization_adapter'

RailsAdmin.add_extension(:pundit2, RailsAdmin::Extensions::Pundit2, { authorization: true })
