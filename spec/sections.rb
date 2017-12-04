
module Sections

    class Menu < SitePrism::Section

        element :navigation_bar, '#navigation-bar'
        element :admin_dasboard, 'a[ui-sref="admin.dashboard"]'
        element :admin_setup, 'a[ui-sref="admin.setup"]'
        element :admin_e911, 'a´[ui-sref="admin.e911"]'
        element :admin_reports, 'a[ui-sref="admin.reporting-analytics"]'
        element :admin_announcements, 'a[ui-sref="admin.announcement-center"]'
        element :admin_account_billing, 'a[ui-sref="admin.account-billing-information"]'
        element :admin_support

    end

    class SetupMenu < SitePrism::Section
        element :users, 'a[ui-sref="admin.setup.user"]'
        element :departments, 'a[ui-sref="admin.setup.department"]'
        element :menu, 'a[ui-sref="admin.setup.menu"]'
        element :phone_number, 'a[ui-sref="admin.setup.phone-number"]'

    end


end


