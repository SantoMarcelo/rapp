
require_relative '../../../../pages/login/login'
require_relative '../../../../pages/admin/dashboard/dashboard'
require_relative '../../../../pages/admin/setup/user/users'

describe('validate Users Setup', :user_setup) do
  before(:each) do
   
    login_page.load
    login_page.do_login($admin_user)
    home.wait_until_home_menu_visible
    home.wait_until_user_status_visible
    home.goto_admin
    admin_dashboard.wait_until_btn_continue_visible
    admin_dashboard.btn_continue.click

    @user1 = {
      extension: '101',
      name: 'Dev Marcelo 1 User',
      first_name: 'Dev Marcelo 1',
      last_name: 'User',
      email: 'devmarcelo.user1@ringbyname.com',
      new_password: 'dsa654321',
      type: 'R! User',
      direct: '12392080525',
      outbound_caller_id: '12392080525 (New user 9314129)',
      voicemail_password: '1234',
      number_of_rings: '5',
      landline_name: 'Cellphone Test',
      landline_number: '011554899999999',
      device_username: 'Username: 9314129',
      device_authname: 'Auth Name: 9314129',
      device_password: 'Password: 123456asd',
      device_sip: 'SIP Server: 1168173.sip.dev.ringbyname.com',
      text_to_speech: 'Thanks for calling to Dev QC'

    }
    @user2 = {
      username: 'devmarcelo.user2@ringbyname.com',
      password: '123456asd',
      extension: '102',
      name: 'Dev Marcelo 2 User',
      type: 'R! User',
      direct: 'None'
    }
    @user3 = {
      extension: '103',
      name: 'Dev Marcelo 3 User',
      type: 'R! Virtual User',
      direct: 'None',
      username: 'devmarcelo.user3@ringbyname.com',
      password: '123456asd'
    }
    @user4 = {
      extension: '104',
      name: 'Dev Marcelo 4 User',
      email: 'devmarcelo.user4@ringbyname.com',
      type: 'R! Virtual User',
      direct: 'None',
      first_name: 'Dev Marcelo 4',
      last_name: 'User',
      username: 'devmarcelo.user4@ringbyname.com',
      password: '123456asd'
    }
    @user_changed = {
      username: 'devmarcelo.user1.CHANGED@ringbyname.com',
      password: 'dsa654321',
      extension: '999',
      name: 'Dev Marcelo 1 CHANGED User CHANGED',
      first_name: 'Dev Marcelo 1 CHANGED',
      last_name: 'User CHANGED',
      email: 'devmarcelo.user1.CHANGED@ringbyname.com',
      type: 'R! User',
      direct: '12392080525',
      outbound_caller_id: '12392068773 (Dev Comp 1 Marcelo)',
      voicemail_password: '1234',
      number_of_rings: '10',
      caller_custom_number: '9999999999',
      caller_custom_name: 'Test Custom Name'
    }
    @user_restored = {
      first_name: 'New User',
      last_name: '9314132',
      email: '407808@ringbyname.com',
      extension: '104',
      name: 'New User 9314132',
      type: 'R! Virtual User',
      direct: 'None',
      username: '407808@ringbyname.com',
      password: 'ahc9Ha4rt4Aa'
    }
    # Capybara.ignore_hidden_elements = true
  end

  describe('validate users list', :user_list) do
    it('access user setup and validate user list') do |e|
      puts 'access user setup and validate user list'
      e.step('when I on admin page') do
        puts 'when I on admin page'
        admin_dashboard.options.admin_setup.click
      end
      e.step('I can see the user setup') do
        puts 'I can see the user setup'
        expect(users.admin_title.text).to eql 'Setup'
      end
      e.step('and I can access the user setings') do
        puts 'and I can access the user setings'
        users.access_user_menu
        expect(users.user_main.title.text).to eql 'Users'
      end
      e.step('then I check user list') do
        puts 'then I check user list'
        expect(users.is_user_in_grid(@user1)).to eql true
        expect(users.is_user_in_grid(@user2)).to eql true
        expect(users.is_user_in_grid(@user3)).to eql true
        expect(users.is_user_in_grid(@user4)).to eql true
        expect(users.user_main.info_total_records.text).to eql '14'
      end
      e.step('when I check the total of users')do
        puts 'when I check the total of users'
        expect(users.setup.select_number_pages.text.include?('10'))
        expect(users.setup.info_total_records.text).to eql '14'
        expect(users.setup.grid_rows.length).to eql 10
      end
      e.step('and I change the page')do
        puts 'and I change the page'
        users.setup.change_page(2)
        sleep 1
        # users.wait_until_load_visible
        # users.wait_until_load_invisible
        
        expect(users.setup.info_total_records.text).to eql '14'
      end
      e.step('then I can see the second page')do
        puts 'then I can see the second page'
        users.setup.wait_for_grid_rows
        expect(users.setup.grid_rows.length).to eql 4
      end
      e.step('when I change the total of records per page to the minimum # of records')do
        puts 'when I change the total of records per page to the minimum # of records'
        users.setup.change_page(1)
        users.setup.wait_for_grid_rows
        # users.wait_until_load_invisible
        sleep 1
        users.setup.select_number_page_options.each do |u|
          u.click if u.text.include?('5')
          break
        end
        sleep 1
        # users.wait_until_load_visible
        # users.wait_until_load_invisible
      end
      e.step('then I can see the three pages.') do
        puts 'then I can see the three pages.'
        expect(users.setup.grid_rows.length).to eql 5
        users.setup.change_page(2)
        users.setup.wait_for_grid_rows
        sleep 1
        # users.wait_until_load_visible
        # users.wait_until_load_invisible
        expect(users.setup.grid_rows.length).to eql 5
        users.setup.change_page(3)
        users.setup.wait_for_grid_rows
        sleep 1
        # users.wait_until_load_visible
        # users.wait_until_load_invisible
        expect(users.setup.grid_rows.length).to eql 4
      end
      e.step('when I change the total of records per page to the maximum # of records') do
        puts 'when I change the total of records per page to the maximum # of records'
        users.setup.change_page(1)
        users.setup.wait_for_grid_rows
        sleep 1
        # users.wait_until_load_visible
        # users.wait_until_load_invisible
        users.setup.select_number_page_options.each do |u|
          u.click if u.text == ('50')
        end
      end
      e.step('then I can see the one page with all registers.')do
        puts 'then I can see the one page with all registers.'
        users.setup.wait_for_grid_rows
        sleep 1
        # users.wait_until_load_invisible
        # need to check why not count all list itens
        expect(users.setup.grid_rows.length).to eql 10
      end
    end
  end

  describe('search users', :search_user) do
    it('validate all search cases') do |e|
      puts 'validate all search cases'
      e.step('when I on users setup') do
        puts 'when I on users setup'
        admin_dashboard.options.admin_setup.click
        expect(users.admin_title.text).to eql 'Setup'
        users.access_user_menu
        expect(users.user_main.title.text).to eql 'Users'
      end
      e.step('and search by extension') do
        puts 'and search by extension'
        users.user_main.txt_search.set (@user1[:extension])
        users.user_main.btn_search.click
      end
      e.step('then i can see only the filtred user') do
        puts 'then i can see only the filtred user'
        expect(users.is_user_in_grid(@user1)).to eql true
        expect(users.user_main.info_total_records.text).to eql '1'
      end
      e.step('and search by name') do
        puts 'and search by name'
        users.user_main.txt_search.set (@user2[:name])
        users.user_main.btn_search.click
      end
      e.step('then i can see only the filtred user') do
        puts 'then i can see only the filtred user'
        # users.user_main.wait_until_grid_rows_visible
        sleep 1
        expect(users.is_user_in_grid(@user2)).to eql true
        expect(users.user_main.info_total_records.text).to eql '1'
      end
      e.step('and search by type') do
        puts 'and search by type'
        users.user_main.txt_search.set (@user3[:type])
        users.user_main.btn_search.click
      end
      e.step('then i can see only the filtred user') do
        puts 'then i can see only the filtred user'
        sleep 1
        expect(users.is_user_in_grid(@user3)).to eql true
        expect(users.user_main.info_total_records.text).to eql '2'
      end
      e.step('and search by Direct#') do
        puts 'and search by Direct#'
        users.user_main.txt_search.set (@user1[:direct])
        users.user_main.btn_search.click
      end
      e.step('then i can see only the filtred user') do
        puts 'then i can see only the filtred user'
        sleep 1
        expect(users.is_user_in_grid(@user1)).to eql true
        expect(users.user_main.info_total_records.text).to eql '1'
      end
      e.step('and search with special character') do
        puts 'and search with special character'
        users.user_main.txt_search.set '!@#$%¨&*()'
        users.user_main.btn_search.click
      end
      e.step('then i can see only the filtred user') do
        puts 'then i can see only the filtred user'
        sleep 1
        expect(users.user_main.grid_rows.empty?).to eql true
        expect(users.user_main.info_total_records.text).to eql '0'
      end
      e.step('validate clear search field') do
        puts 'validate clear search field'
        users.user_main.txt_search.set 'Clear search field'
        users.user_main.btn_clear_search.click
      end
      e.step('validate what field is cleared and grid was refreshd with all users') do
        puts 'validate what field is cleared and grid was refreshd with all users'
        expect(users.user_main.txt_search.text).to eql ''
        expect(users.is_user_in_grid(@user1)).to eql true
        expect(users.is_user_in_grid(@user2)).to eql true
        expect(users.is_user_in_grid(@user3)).to eql true
        expect(users.is_user_in_grid(@user4)).to eql true
        expect(users.user_main.info_total_records.text).to eql '4'
      end
      e.step('validate search tooltips text') do
        puts 'validate search tooltips text'
        users.user_main.icon_search_tooltip.click
        users.tooltips.wait_until_tooltip_text_visible
        expect(users.tooltips.tooltip_text.text).to eql 'Enter any Extension number, telephone number, or name to find it in your account.'
      end
      e.step('validate grid tooltip') do
        puts 'validate grid tooltip'
        users.user_main.icon_grid_tooltip.click
        users.tooltips.wait_until_tooltip_text_visible
        expect(users.tooltips.tooltip_text.text).to eql 'Click on Deactivate to remove a user from the system and reset all of its stored settings. Deactivating an extension will remove all stored settings, voicemails, and configurations.'
      end
    end
  end

  describe('validate users details', :user_details) do
    it('validate user information') do |e|
      puts 'validate user information'
      e.step('when I on users setup') do
        puts 'when I on users setup'
        admin_dashboard.options.admin_setup.click
      end
      e.step('and I select the first user') do
        puts 'and I select the first user'
        users.select_user_in_grid(@user1)
      end
      e.step('then I check user\' informations') do
        puts 'then I check user\'s informations'
        expect(users.details.txt_first_name.text.include?(@user1[:first_name]))
        expect(users.details.txt_last_name.text.include?(@user1[:last_name]))
        expect(users.details.txt_email.text.include?(@user1[:email]))
        expect(users.details.txt_extension.text.include?(@user1[:extension]))
        expect(users.details.txt_direct_number.text.include?(@user1[:direct]))
        expect(users.details.select_outbound_caller_id.text.include?(@user1[:outbound_caller_id]))
        voicemail_active = expect(users.details.checkbox_voicemail(visible: false)).to be_checked
        if voicemail_active == true
          expect(users.details.txt_voicemail_password.text.include?(@user1[:voicemail_password]))
        end
        expect(users.details.radio_auto_greeting(visible: false)).to be_checked
        expect(users.details.radio_text_greeting(visible: false)).not_to be_checked
        expect(users.details.radio_file_greeting(visible: false)).not_to be_checked
        expect(users.details.checkbox_callback_request(visible: false)).to be_checked
        expect(users.details.checkbox_require_key_press(visible: false)).to be_checked
        expect(users.details.txt_number_rings.text.include?(@user1[:number_of_rings]))
        expect(users.details.checkbox_inbound_call_recording(visible: false)).not_to be_checked
        expect(users.details.checkbox_outbound_call_recording(visible: false)).not_to be_checked
        expect(users.details.checkbox_call_pickup(visible: false)).to be_checked
      end
      e.step('and I validate all tooltips texts') do
        puts 'and I validate all tooltips texts'
        # Add all tooltips text in array to validate with array returned in validation method.
        tooltips_texts_expect = [
          'Please enter an e-mail to be used as a login for this user. This must be a unique e-mail. This email will also be used to send notifications to the user, such as new voicemail and fax alerts.',
          'Please enter a password for this user. Passwords are alphanumeric and may contain letter and number combinations as well as special characters.',
          'Please re-enter your password to check for accuracy.',
          'You may enter any 3 to 5-digit extension number not currently in use in your account',
          'This is the direct telephone number that has been assigned to this user by the system administrator. If you would like to change the telephone number assigned, please navigate to the Phone Numbers section of the admin panel.',
          'You may select what outbound caller ID will be used by this user when placing a call. This number will be displayed to all telephone numbers dialed by this user. To assign the same Outbound Caller ID to more than one user, consider using the "Set Outbound Caller ID for Mutlitiple Users" tool.',
          'Click on this option if you wish to attach an additional VoIP telephone, or software based softphone to this user.',
          'Click on this checkbox to enable routing of calls to a specific device.',
          'Click on this option if you would like the system to simultaneously route calls to a landline or mobile phone. Expert Tip: Try forwarding calls to a colleague while you are away on vaction, simply enter their extension number instead of a landline or mobile phone number',
          "Click on this checkbox to enable or disable voicemail for this user\'s extensions",
          'Enter any 4-digit numeric password for voicemail box access',
          'Select this option if you would like the system to use an automated voicemail greeting.',
          'Select a language and enter the voicemail greeting you would like the system to read to your callers',
          'Use this option if you would like to use an MP3 ro WAV file as a voicemail greeting',
          'Click on this checkbox to grant this user Administrator access to the system and all configuration settings.'
        ]
        users.details.wait_until_btn_save_user_visible
        expect(users.validate_details_tooltips).to eql tooltips_texts_expect
      end
    end
 
  end

  describe('validate users update', :user_update) do
    it('update users and check changed data') do |e|
      puts 'update users and check changed data'
      e.step('when I on users setup') do
        puts 'when I on users setup'
        admin_dashboard.options.admin_setup.click
      end
      e.step('and I select the first user') do
        puts 'and I select the first user'
        users.select_user_in_grid(@user1)
      end
      #update general information
      e.step('and I change user informatios') do
        puts 'and I change user informatios'
        users.details.txt_first_name.set (@user_changed[:first_name])
        users.details.txt_last_name.set (@user_changed[:last_name])
        users.details.txt_email.set (@user_changed[:email])
        users.details.txt_extension.set (@user_changed[:extension])
        users.details.select_outbound_caller_id.find('option', text: (@user_changed[:outbound_caller_id])).select_option
      #get all checkboxes on the user datails and click in the each.
      
        users.details.checkboxes.each do |u|
          u.click if u.text.include?('Enable Voicemail Box of User Calls')
          u.click if u.text.include?('Use Callback Request')
          u.click if u.text.include?('Require key press to accept transferred calls')
          u.click if u.text.include?('Enable inbound call recording for this user')
          u.click if u.text.include?('Enable outbound call recording for this user')
          u.click if u.text.include?('Allow others to remotely answer this user\'s calls')
        end
        users.details.btn_save_user.click
        users.message.wait_until_modal_visible
        expect(users.message.modal.text).to eql 'User updated successfully.'
        users.message.btn_ok.click
      end
      e.step('then I check if all changes are displayed correctly') do
        puts 'then I check if all changes are displayed correctly'
        users.select_user_in_grid(@user_changed)
        users.details.wait_until_btn_save_user_visible
        expect(users.details.txt_first_name.text.include?(@user_changed[:first_name]))
        expect(users.details.txt_last_name.text.include?(@user_changed[:last_name]))
        expect(users.details.txt_email.text.include?(@user_changed[:email]))
        expect(users.details.txt_extension.text.include?(@user_changed[:extension]))
        expect(users.details.txt_direct_number.text.include?(@user_changed[:direct]))
        expect(users.details.select_outbound_caller_id.text.include?(@user_changed[:outbound_caller_id]))
        expect(users.details.checkbox_voicemail(visible: false)).not_to be_checked
        expect(users.details.checkbox_callback_request(visible: false)).not_to be_checked
        expect(users.details.checkbox_require_key_press(visible: false)).not_to be_checked
        expect(users.details.txt_number_rings.text.include?(@user_changed[:number_of_rings]))
        expect(users.details.checkbox_inbound_call_recording(visible: false)).to be_checked
        expect(users.details.checkbox_outbound_call_recording(visible: false)).to be_checked
        expect(users.details.checkbox_call_pickup(visible: false)).not_to be_checked
      end
      e.step('when I change the user password')do
        puts 'when I change the user password'
        users.details.txt_password.each do |u|
          u.set(@user_changed[:password])
          break
        end
        users.details.txt_password_repeart.set(@user_changed[:password])
        users.details.btn_save_user.click
        users.message.wait_until_modal_visible
        expect(users.message.modal.text).to eql 'User updated successfully.'
        users.message.btn_ok.click
        expect(users.is_user_in_grid(@user_changed)).to eql true
        
        users.main_menu.menu.click
        users.main_menu.logout.click
       end
      e.step('then I can login in the system with this new password')do
        puts 'then I can login in the system with this new password'
        login_page.do_login(@user_changed)
        home.wait_until_home_menu_visible
        home.wait_until_user_status_visible
      end
      e.step('and I return to users setup')do
        puts 'and I return to users setup'
        home.goto_admin
        admin_dashboard.options.admin_setup.click
        expect(users.admin_title.text).to eql 'Setup'
        users.access_user_menu
        expect(users.user_main.title.text).to eql 'Users'
      end
      e.step('when I change outbound caller to custom options')do
        puts 'when I change outbound caller to custom options'
        users.select_user_in_grid(@user_changed)
        users.details.select_outbound_caller_id.find('option', text: '(Click here)').select_option
        users.details.txt_caller_custom_number.set(@user_changed[:caller_custom_number])
        users.details.txt_caller_custom_name.set(@user_changed[:caller_custom_name])
        users.details.btn_save_user.click
        users.message.wait_until_modal_visible
        expect(users.message.modal.text).to eql 'User updated successfully.'
        users.message.btn_ok.click
      end
      e.step('then I verify outbound caller changes')do
        puts 'then I verify outbound caller changes'
        users.select_user_in_grid(@user_changed)
        expect(users.details.select_outbound_caller_id.text.include?(@user_changed[:caller_custom_number]))
        expect(users.details.txt_caller_custom_name.text.include?(@user_changed[:caller_custom_name]))
        admin_dashboard.goto_home
        expect(home.my_caller_id.text.include?(@user_changed[:caller_custom_number]))
      end
      e.step('when I insert others devices')do
        puts 'when I insert others devices'
        home.goto_admin
        admin_dashboard.options.admin_setup.click
        expect(users.admin_title.text).to eql 'Setup'
        users.access_user_menu
        expect(users.user_main.title.text).to eql 'Users'
        users.select_user_in_grid(@user_changed)
        users.details.link_add_device.click
        expect(users.details.checkboxes_device.length).to eql 2
        users.details.link_devices_name.each do |u|
          expect(u.text.include?('VoIP Device 9314129*'))
        end
        users.details.btn_save_user.click
        users.message.wait_until_modal_visible
        expect(users.message.modal.text).to eql 'User updated successfully.'
        users.message.btn_ok.click
      end
      e.step('then I verify if the device was inserted correctly')do
        puts 'then I verify if the device was inserted correctly'
        users.select_user_in_grid(@user_changed)
        users.details.link_devices_name.each do |u|
          expect(u.text.include?('VoIP Device 9314129a'))
        end
      end
      e.step('when I validate the maximum number of devices')do
        puts 'when I validate the maximum number of devices'
        sleep 1
        users.details.link_add_device.click
        users.details.link_devices_name.each do |u|
          expect(u.text.include?('VoIP Device 9314129*'))
        end
        users.details.link_add_device.click
        users.details.link_devices_name.each do |u|
          expect(u.text.include?('VoIP Device 9314129*'))
        end
        users.details.link_add_device.click
        users.details.link_devices_name.each do |u|
          expect(u.text.include?('VoIP Device 9314129*'))
        end
        users.details.link_add_device.click
        users.details.link_devices_name.each do |u|
          expect(u.text.include?('VoIP Device 9314129*'))
        end
        expect(users.details.checkboxes_device.length).to eql 5
      end
      e.step('then I can see the validation message')do
        puts 'then I can see the validation message'
        users.device_modal.wait_until_modal_title_visible
        expect(users.device_modal.modal_title.text).to eql 'Maximum Number of Devices Reached'
        expect(users.device_modal.modal_message.text).to eql 'You have reached the limit of devices per user.'
        users.device_modal.modal_button.click
      end
      e.step('and when I delete an inserted devices')do
        puts 'and when I delete an inserted devices'
        expect(page).to have_css('.control i.icon-fontello-trash-empty')
        users.details.icon_delete_device.each do |u|
          u.click
        end
        users.details.link_devices_name.each do |u|
          expect(u.text.include?('VoIP Device 9314129a')).to eql false
          expect(u.text.include?('VoIP Device 9314129b')).to eql false
          expect(u.text.include?('VoIP Device 9314129c')).to eql false
          expect(u.text.include?('VoIP Device 9314129d')).to eql false
        end
        users.details.btn_save_user.click
        users.message.wait_until_modal_visible
        expect(users.message.modal.text).to eql 'User updated successfully.'
        users.message.btn_ok.click
      end
      e.step('then I not see the device what was inserted')do
        puts 'then I not see the device what was inserted'
        users.select_user_in_grid(@user_changed)
        users.details.link_devices_name.each do |u|
          expect(u.text.include?('VoIP Device 9314129a')).to eql false
        end
      end
      e.step('and when I select device to see the config specs')do
        puts 'and when I select device to see the config specs'
        users.details.link_devices_name.each do |u|
          u.click
        end
      end
      e.step('then I see the modal with device configuration')do
        puts 'then I see the modal with device configuration'
        expect(users.device_config_modal.modal_title.text).to eql 'VoIP Configuration Settings'
        expect(users.device_config_modal.modal_body.text.include?(@user1[:device_username]))
        expect(users.device_config_modal.modal_body.text.include?(@user1[:device_authname]))
        expect(users.device_config_modal.modal_body.text.include?(@user1[:device_password]))
        expect(users.device_config_modal.modal_body.text.include?(@user1[:device_sip]))
        users.device_config_modal.close.click
      end
      #landline validations
      e.step('when I add a cellphone or landline')do
        puts 'when I add a cellphone or landline'
        users.details.link_add_cell_landline.click
        users.wait_until_landline_modal_visible
        expect(users.landline_modal.modal_title.text).to eql 'Add another mobile or landline destination'
        #validate tooltips landline form
        #@expect_tooltip_texts = ['TOOLTIP_MOBILELANDILINE_NAME', 'TOOLTIP_MOBILELANDILINE_NUMBER']
        # @tooltip_landline_texts = []
        # users.landline_modal.tooltips.each do |u|
        #   puts u.text
        #   puts u.inspect
        #   u.click
        #   @tooltip_landline_texts.push(users.tooltips.tooltip_text.text)
        #   u.click
        # end
        # expect(@tooltip_landline_texts). to eql @expect_tooltip_texts
        # #end tooltip validation
        users.landline_modal.txt_landline_name.set(@user1[:landline_name])
        users.landline_modal.txt_landline_number.set(@user1[:landline_number])
        users.landline_modal.btn_save.click
        users.details.link_landline_items.each do |u|
          expect(u.text.include?(@user1[:landline_name]))
          expect(u.text.include?(@user1[:landline_number]))
        end
        users.details.btn_save_user.click
        users.message.wait_until_modal_visible
        expect(users.message.modal.text).to eql 'User updated successfully.'
        users.message.btn_ok.click
      end
      e.step('then I validate if landline was inserted correctly')do
        puts 'then I validate if landline was inserted correctly'
        users.select_user_in_grid(@user_changed)
        users.details.link_landline_items.each do |u|
          expect(u.text.include?(@user1[:landline_name]))
          expect(u.text.include?(@user1[:landline_number]))
        end
      end
      e.step('and when I delete a inserted landlines')do
        puts 'and when I delete a inserted landlines'
        users.details.icon_delete_device.each do |u|
          u.click
        end
        users.details.link_landline_items.each do |u|
          expect(u.text.include?(@user1[:landline_name])).to eql false
          expect(u.text.include?(@user1[:landline_number])).to eql false
        end
        users.details.btn_save_user.click
        users.message.wait_until_modal_visible
        expect(users.message.modal.text).to eql 'User updated successfully.'
        users.message.btn_ok.click
      end
      e.step('then I validate if the landline was deleted correctly')do
        puts 'then I validate if the landline was deleted correctly'
        users.select_user_in_grid(@user_changed)
        users.details.link_landline_items.each do |u|
          expect(u.text.include?(@user1[:landline_name])).to eql false
          expect(u.text.include?(@user1[:landline_number])).to eql false
        end
      end
      e.step('when I select text to speech greeting option')do
        puts 'when I select text to speech greeting option'
        users.details.checkboxes.each do |u|
          u.click if u.text.include?('Enable Voicemail Box of User Calls')
        end
        users.details.radios.each do |u|
          if u.text.include?('Say this')
            u.click
          end
        end
      end
      e.step('and I fill the text and select English language')do
        users.details.txt_text_greeting.set(@user1[:text_to_speech])
        users.details.select_language.find('option', text: 'English').select_option
        users.details.btn_save_user.click
        users.message.wait_until_modal_visible
        expect(users.message.modal.text).to eql 'User updated successfully.'
        users.message.btn_ok.click
      end
      e.step('then I check the selected option') do
        puts 'then I check the selected option'
        users.select_user_in_grid(@user_changed)
        expect(users.details.radio_auto_greeting(visible: false)).to be_checked
        expect(users.details.select_language.text.include?('English'))
      end
      e.step('when I change language to Spanish')do
        puts 'when I change language to Spanish'
        users.details.select_language.find('option', text: 'Spanish').select_option
        users.details.btn_save_user.click
        users.message.wait_until_modal_visible
        expect(users.message.modal.text).to eql 'User updated successfully.'
        users.message.btn_ok.click
      end
      e.step('then I check if was saved correctly')do
        puts 'then I check if was saved correctly'
        users.select_user_in_grid(@user_changed)
        expect(users.details.radio_auto_greeting(visible: false)).to be_checked
        expect(users.details.select_language.text.include?('Spanish'))
      end
      e.step('when I change language to Portuguese')do
        puts 'when I change language to Portuguese'
        users.details.select_language.find('option', text: 'Portuguese').select_option
        users.details.btn_save_user.click
        users.message.wait_until_modal_visible
        expect(users.message.modal.text).to eql 'User updated successfully.'
        users.message.btn_ok.click
      end
      e.step('then I check if was saved correctly')do
        puts 'then I check if was saved correctly'
        users.select_user_in_grid(@user_changed)
        expect(users.details.radio_auto_greeting(visible: false)).to be_checked
        expect(users.details.select_language.text.include?('Portuguese'))
      end
    
      e.step('when I remove admin permission from other user')do
        puts 'when I remove admin permission from other user'
        users.select_user_in_grid(@user2)
        users.details.checkboxes.each do |u|
          u.click if u.text.include?('Make this user an admin')
        end
         users.details.btn_save_user.click
         users.message.wait_until_modal_visible
         expect(users.message.modal.text).to eql 'User updated successfully.'
         users.message.btn_ok.click
         sleep 1
      end
      e.step('then I can\'t see this user like admin in user grid')do
        puts 'then I can\'t see this user like admin in user grid'
        users.setup.wait_for_grid_rows
        expect(users.setup.grid_icon_admin.length).to eql 3
        users.select_user_in_grid(@user2)
        expect(users.details.checkbox_admin_permission(visible: false)).not_to be_checked
      end
      e.step('when I login with an user what isn\'t a admin')do
        puts 'when I login with an user what isn\'t a admin'
        users.main_menu.menu.click
        users.main_menu.logout.click
        login_page.do_login(@user2)
        home.wait_until_home_menu_visible
        home.wait_until_user_status_visible
      end
      e.step('then I\'ll dont\'t have acces to admin page')do
        puts 'then I\'ll dont\'t have acces to admin page'
        home.menu_access
        expect(home.dropdown_menu.has_goto_admin?).to eql false
      end
      e.step('when I try to remove admin permission to the same logged user')do
        puts 'when I try to remove admin permission to the same logged user'
        home.dropdown_menu.logout.click
        login_page.wait_for_txt_user
        login_page.do_login(@user_changed)
        home.wait_until_home_menu_visible
        home.wait_until_user_status_visible
        home.goto_admin
        admin_dashboard.options.admin_setup.click
        expect(users.admin_title.text).to eql 'Setup'
        users.access_user_menu
        expect(users.user_main.title.text).to eql 'Users'
        users.select_user_in_grid(@user_changed)
      end
      e.step('then I can see disabled field')do
        puts 'then I can see disabled field'
        expect(users.details.checkbox_admin_permission(visible: false).disabled?).to eql true
      end
      # e.step('when I upload a media to my greeting') do
      #   puts 'when I upload a media to my greeting'
      #  # Capybara.ignore_hidden_elements = false
       
      #  page.execute_script("$('.fileinput-button :file').attr(\"style\", \"position:initial !important;top:initial !important;right:initial !important;opacity:initial !important;font-size:initial !important\");")
      #  #users.details.link_upload_voicemail_file.click
      #  target = 'medias/hold_music.mp3'
      #  puts File.join(Dir.pwd, target)
      #  attach_file(users.details.link_upload_voicemail_file, (File.join(Dir.pwd, target)))
      # end
      
    end
    after do
      puts 'Return to original data'
      # return user data to default
      users.details.txt_first_name.set (@user1[:first_name])
      users.details.txt_last_name.set (@user1[:last_name])
      users.details.txt_email.set (@user1[:email])
      users.details.txt_password.each do |u|
        u.set('123456asd')
        break
      end
      users.details.txt_password_repeart.set('123456asd')
      users.details.txt_extension.set (@user1[:extension])
      users.details.select_outbound_caller_id.find('option', text: (@user1[:outbound_caller_id])).select_option
      users.details.checkboxes.each do |u|
        u.click if u.text.include?('Use Callback Request')
        u.click if u.text.include?('Require key press to accept transferred calls')
        u.click if u.text.include?('Enable inbound call recording for this user')
        u.click if u.text.include?('Enable outbound call recording for this user')
        u.click if u.text.include?('Allow others to remotely answer this user\'s calls')
      end
      users.details.txt_text_greeting.set('')
      users.details.radios.each do |u|
        if u.text.include?('Use Automatic Greeting')
          u.click
          end
      end
      users.details.txt_text_greeting.set('')
      users.details.txt_number_rings.set(@user1[:number_of_rings])
      users.details.btn_save_user.click
      users.message.wait_until_modal_visible
      expect(users.message.modal.text).to eql 'User updated successfully.'
      users.message.btn_ok.click
      users.is_user_in_grid(@user1)
      users.select_user_in_grid(@user2)
      users.details.checkboxes.each do |u|
        u.click if u.text.include?('Make this user an admin')
      end
      users.details.btn_save_user.click
      users.message.wait_until_modal_visible
      expect(users.message.modal.text).to eql 'User updated successfully.'
      users.message.btn_ok.click
    end
  end

  describe('validate user reset data', :user_reset) do
    it('reset user data and check new data')do |e|
      puts 'reset user data and check new data'
      e.step('when I on users setup') do
        puts 'when I on users setup'
        admin_dashboard.options.admin_setup.click
      end
      e.step('and I select the user to reset data') do
        puts 'and I select the user to reset data'
        users.select_user_in_grid(@user4)
      end
      e.step('and I cancel reset user data')do
        puts 'and I cancel reset user data'
        users.details.btn_reset_user.click
        users.reset_modal.wait_for_modal_title
        expect(users.reset_modal.modal_title.text).to eql 'Reset User Settings'
        expect(users.reset_modal.modal_message.text).to eql "Please confirm you wish to reset this user and erase all user settings."
        users.reset_modal.modal_btn_cancel.click
      end
      e.step('the I return to user details')do
        puts 'the I return to user details'
        users.wait_until_reset_modal_invisible
        expect(users.has_reset_modal?).to eql false
      end
      e.step('when I confirm reset user data')do
        puts 'when I confirm reset user data'
        users.details.btn_reset_user.click
        users.wait_for_reset_modal
        expect(users.reset_modal.modal_title.text).to eql 'Reset User Settings'
        expect(users.reset_modal.modal_message.text).to eql 'Please confirm you wish to reset this user and erase all user settings.'
        users.reset_modal.modal_btn_save.click
        #confirmation message
        users.wait_for_message
        expect(users.message.modal.text).to eql 'User restored successfully'
        users.message.btn_ok.click
      end
      e.step('then I can see the all data restored')do
        puts 'then I can see the all data restored'
        users.is_user_in_grid(@user_restored)
        users.select_user_in_grid(@user_restored)
        expect(users.details.txt_first_name.text.include?(@user_restored[:first_name]))
        expect(users.details.txt_last_name.text.include?(@user_restored[:last_name]))
        expect(users.details.txt_email.text.include?(@user_restored[:email]))
        expect(users.details.txt_extension.text.include?(@user_restored[:extension]))
        expect(users.details.txt_direct_number.text.include?(@user_restored[:direct]))
      end
      e.step('and I validate the login with the new user data')do
        puts 'and I validate the login with the new user data'
        users.main_menu.menu.click
        users.main_menu.logout.click
        login_page.do_login(@user_restored)
        home.wait_until_home_menu_visible
        home.wait_until_user_status_visible
        expect(login_page.current_url).to end_with '/#!/app/welcome-page'
      end
    end 

    after do
      puts 'return user data to default'
      home.goto_admin
      admin_dashboard.options.admin_setup.click
      expect(users.admin_title.text).to eql 'Setup'
      users.access_user_menu
      expect(users.user_main.title.text).to eql 'Users'
      users.select_user_in_grid(@user_restored)
      users.details.txt_first_name.set(@user4[:first_name])
      users.details.txt_last_name.set(@user4[:last_name])
      users.details.txt_email.set(@user4[:email])
      users.details.txt_password.each do |u|
        u.set(@user4[:password])
        break
      end
      users.details.txt_password_repeart.set(@user4[:password])
      users.details.txt_extension.set(@user4[:extension])
      
      users.details.btn_save_user.click
      users.message.wait_until_modal_visible
      expect(users.message.modal.text).to eql 'User updated successfully.'
      users.message.btn_ok.click
      expect(users.is_user_in_grid(@user4)).to eql true
    end
  end

  describe('Validate CRM Feature', :crm_feature) do
    it('update users to enable CRM feature') do |e|
      e.step('when I on users setup') do
        admin_dashboard.options.admin_setup.click
      end
      e.step('and I select the first user') do
        users.select_user_in_grid($user1)
      end
      e.step('then I allow CRM feature to user') do
        users.crm_feature_enable
        expect(users.message.modal.text).to eql 'User updated successfully.'
        users.message.btn_ok.click
      end
      e.step('and I check if the change was saved correctly') do
        users.setup.wait_for_grid_rows
        expect(users.setup.grid_icon_crm.length).to eql 1
        users.select_user_in_grid($user1)
        expect(users.details.checkbox_crm(visible: false)).to be_checked
      end
    end

    it('check maximum number of license validation message') do |e|
      e.step('given I has only 1 CRM license') do
        # expect(users.get_number_of_crm_licenses).to eql 1
      end
      e.step('when I on users setup') do
        admin_dashboard.options.admin_setup.click
      end
      e.step('and I allow CRM feature to users') do
        users.select_user_in_grid($user2)
        users.crm_feature_enable
      end
      e.step('then I see the validation message') do
        expect(users.message.modal.text).to eql "Sorry, but you've reached the maximum number of CRM licenses for your account. If you still want to enable the CRM feature for this user, please buy another license or disable CRM of another user before proceeding."
      end
    end

    it('update users to disable CRM feature') do |e|
      e.step('when I on users setup') do
        admin_dashboard.options.admin_setup.click
      end
      e.step('and I select the first user') do
        users.select_user_in_grid($user1)
      end
      e.step('then I unallow CRM feature to user') do
        users.crm_feature_disable
        expect(users.message.modal.text).to eql 'User updated successfully.'
        users.message.btn_ok.click
      end
      e.step('and I check if the change was saved correctly') do
        users.setup.wait_for_grid_rows
        expect(users.setup.grid_icon_crm.length).to eql 0
        users.select_user_in_grid($user1)
        sleep(2)
        expect(users.details.checkbox_crm(visible: false)).not_to be_checked
      end
    end
  end

  describe('Validate Outbound Caller ID massive update', :user_massive_cId) do
    it('set the same caller id to all users and validate') do |e|
      puts 'set the same caller id to all users and validate'
      e.step('when I on users setup') do
        admin_dashboard.options.admin_setup.click
      end
      e.step('and I select the massive update link')do
        puts 'and I select the massive update link'
        users.setup.link_outbound_caller.click
        expect(users.details_cId.title.text).to eql 'Set Outbound Caller ID for multiple users'
      end
      e.step('and I select users to update')do
        puts 'and I select users to update'
        users.details_cId.wait_for_users_list
        users.select_massive_user(@user1)
        users.select_massive_user(@user2)
        users.select_massive_user(@user3)
        users.select_massive_user(@user4)
      end
      e.step('and I set the caller id number')do
        puts ('and I set the caller id number')
        users.details_cId.radios_options.each do |u|
          u.click if u.text.include?('Use this number')
        end
        users.details_cId.select_cId_number.find('option', text: '12392068773 (Dev Comp 1 Marcelo)').select_option
        users.details_cId.btn_save.click
        users.message.wait_until_modal_visible
        expect(users.message.modal.text).to eql 'Outbound Caller Id updated successfully.'
        users.message.btn_ok.click
      end
      e.step('then I check if was updated correctly')do
        puts ('then I check if was updated correctly')
        users.select_user_in_grid(@user1)
        users.details.wait_for_txt_first_name
        expect(users.details.select_outbound_caller_id.text.include?('12392068773 (Dev Comp 1 Marcelo)'))
        users.select_user_in_grid(@user2)
        users.details.wait_for_txt_first_name
        expect(users.details.select_outbound_caller_id.text.include?('12392068773 (Dev Comp 1 Marcelo)'))
        users.select_user_in_grid(@user3)
        users.details.wait_for_txt_first_name
        expect(users.details.select_outbound_caller_id.text.include?('12392068773 (Dev Comp 1 Marcelo)'))
        users.select_user_in_grid(@user4)
        users.details.wait_for_txt_first_name
        expect(users.details.select_outbound_caller_id.text.include?('12392068773 (Dev Comp 1 Marcelo)'))
      end
      e.step('and I chek in the home page if displaying updated caller ID') do
        puts 'and I chek in the home page if displaying updated caller ID'
        admin_dashboard.goto_home
        expect(home.my_caller_id.text.include?('12392068773'))
        home.logout
        login_page.do_login(@user2)
        home.wait_until_home_menu_visible
        home.wait_until_user_status_visible
        expect(login_page.current_url).to end_with '/#!/app/welcome-page'
        expect(home.my_caller_id.text.include?('12392068773'))
        home.logout
        login_page.do_login(@user3)
        home.wait_until_home_menu_visible
        home.wait_until_user_status_visible
        expect(login_page.current_url).to end_with '/#!/app/welcome-page'
        expect(home.my_caller_id.text.include?('12392068773'))
        home.logout
        login_page.do_login(@user4)
        home.wait_until_home_menu_visible
        home.wait_until_user_status_visible
        expect(login_page.current_url).to end_with '/#!/app/welcome-page'
        expect(home.my_caller_id.text.include?('12392068773'))
      end
      e.step('when I return to massive update') do
        puts 'when I return to massive update'
        home.goto_admin
        admin_dashboard.options.admin_setup.click
        expect(users.admin_title.text).to eql 'Setup'
        users.access_user_menu
        expect(users.user_main.title.text).to eql 'Users'
        users.setup.link_outbound_caller.click
        expect(users.details_cId.title.text).to eql 'Set Outbound Caller ID for multiple users'
      end
      e.step('and I select all users') do
        puts 'and I select all users'
        users.details_cId.wait_for_users_list
        users.select_massive_user(@user1)
        users.select_massive_user(@user2)
        users.select_massive_user(@user3)
        users.select_massive_user(@user4)
      end
      e.step('and I set the custom caller name and number') do
        puts 'and I set the custom caller name and number'
        users.details_cId.radios_options.each do |u|
          u.click if u.text.include?('Use a custom Outbound Caller ID')
        end
        users.details_cId.txt_cId_custom_name.set('Massive Caller ID')
        users.details_cId.txt_cId_custom_number.set('9999999999')
        users.details_cId.btn_save.click
        users.message.wait_until_modal_visible
        expect(users.message.modal.text).to eql 'Outbound Caller Id updated successfully.'
        users.message.btn_ok.click
      end
      e.step('then I check if was updated correctly in admin') do
        puts 'then I check if was updated correctly in admin'
        users.select_user_in_grid(@user1)
        expect(users.details.select_outbound_caller_id.text.include?('Massive Caller ID'))
        expect(users.details.txt_caller_custom_name.text.include?('9999999999'))
        users.select_user_in_grid(@user2)
        expect(users.details.select_outbound_caller_id.text.include?('Massive Caller ID'))
        expect(users.details.txt_caller_custom_name.text.include?('9999999999'))
        users.select_user_in_grid(@user3)
        expect(users.details.select_outbound_caller_id.text.include?('Massive Caller ID'))
        expect(users.details.txt_caller_custom_name.text.include?('9999999999'))
        users.select_user_in_grid(@user4)
        expect(users.details.select_outbound_caller_id.text.include?('Massive Caller ID'))
        expect(users.details.txt_caller_custom_name.text.include?('9999999999'))
      end
      e.step('and I chek in the home page if displaying updated caller ID') do
        puts 'and I chek in the home page if displaying updated caller ID'
        admin_dashboard.goto_home
        expect(home.my_caller_id.text.include?('9999999999'))
        home.logout
        login_page.do_login(@user3)
        home.wait_until_home_menu_visible
        home.wait_until_user_status_visible
        expect(login_page.current_url).to end_with '/#!/app/welcome-page'
        expect(home.my_caller_id.text.include?('9999999999'))
        home.logout
        login_page.do_login(@user2)
        home.wait_until_home_menu_visible
        home.wait_until_user_status_visible
        expect(login_page.current_url).to end_with '/#!/app/welcome-page'
        expect(home.my_caller_id.text.include?('9999999999'))
        home.logout
        login_page.do_login(@user1)
        home.wait_until_home_menu_visible
        home.wait_until_user_status_visible
        expect(login_page.current_url).to end_with '/#!/app/welcome-page'
        expect(home.my_caller_id.text.include?('9999999999'))
      end
    end
  end

  describe('Validate password massive update', :user_massive_pass) do
    it('set the same password to all users and validate') do |e|
      puts 'set the same password to all users and validate'
      e.step('when I on users setup') do
        admin_dashboard.options.admin_setup.click
      end
      e.step('when I access massive password update')do
        puts 'when I access massive password update'
        users.setup.link_multiple_password.click
        expect(users.details_pass.title.text).to eql 'Set Password for multiple users'
      end
      e.step('and I select all users to set a new password')do
        puts 'and I select all users to set a new password'
        users.details_pass.wait_for_users_list
        users.select_massive_user(@user1)
        users.select_massive_user(@user2)
        users.select_massive_user(@user3)
        users.select_massive_user(@user4)
      end
      e.step('and I set the new password')do
        puts 'and I set the new password'
        users.details_pass.txt_massive_pass.set('asd123456')
        users.details_pass.btn_save.click
        #users.message.wait_until_modal_visible
        #expect(users.message.modal.text).to eql ''
        users.message.btn_ok.click
      end
      e.step('then I check if the password was changed correctly')do
        puts 'then I check if the password was changed correctly'
        user1 = {
          username: 'devmarcelo.user1@ringbyname.com',
          password: 'asd123456'
        }
        user2 = {
          username: 'devmarcelo.user2@ringbyname.com',
          password: 'asd123456'
        }
        user3 = {
          username: 'devmarcelo.user3@ringbyname.com',
          password: 'asd123456'
        }
        user4 = {
          username: 'devmarcelo.user4@ringbyname.com',
          password: 'asd123456'
        }
        users.main_menu.menu.click
        users.main_menu.logout.click
        login_page.do_login(user1)
        home.wait_until_home_menu_visible
        home.wait_until_user_status_visible
        expect(login_page.current_url).to end_with '/#!/app/welcome-page'
        home.logout
        login_page.do_login(user2)
        home.wait_until_home_menu_visible
        home.wait_until_user_status_visible
        expect(login_page.current_url).to end_with '/#!/app/welcome-page'
        home.logout
        login_page.do_login(user3)
        home.wait_until_home_menu_visible
        home.wait_until_user_status_visible
        expect(login_page.current_url).to end_with '/#!/app/welcome-page'
        home.logout
        login_page.do_login(user4)
        home.wait_until_home_menu_visible
        home.wait_until_user_status_visible
        expect(login_page.current_url).to end_with '/#!/app/welcome-page'
      end
      e.step('when I check the min length password validation')do
        puts 'when I check the min length password validation'
        home.goto_admin
        admin_dashboard.options.admin_setup.click
        expect(users.admin_title.text).to eql 'Setup'
        users.access_user_menu
        expect(users.user_main.title.text).to eql 'Users'
        users.setup.link_multiple_password.click
        expect(users.details_pass.title.text).to eql 'Set Password for multiple users'
        users.details_pass.wait_for_users_list
        users.select_massive_user(@user1)
        users.select_massive_user(@user2)
        users.select_massive_user(@user3)
        users.select_massive_user(@user4)
        users.details_pass.txt_massive_pass.set('12345')
        users.details_pass.btn_save.click
      end
      e.step('then I check the validation message')do
        puts 'then I check the validation message'
        users.message.wait_until_modal_visible
        expect(users.message.modal.text).to eql 'Your password must be between 6 and 12 characters long. Please try again.'
        users.message.btn_ok.click
      end
      e.step('when I check the max length password validation')do
        puts 'when I check the max length password validation'
        users.details_pass.txt_massive_pass.set('1234567890123')
        users.details_pass.btn_save.click
      end
      e.step('then I check the validation message')do
        puts 'then I check the validation message'
        users.message.wait_until_modal_visible
        expect(users.message.modal.text).to eql 'Your password must be between 6 and 12 characters long. Please try again.'
        users.message.btn_ok.click
      end
      e.step('when I check the password composition')do
        puts 'when I check the password composition'
        users.details_pass.txt_massive_pass.set('testtest')
        users.details_pass.btn_save.click
      end
      e.step('then I check the validation message')do
        puts 'then I check the validation message'
        users.message.wait_until_modal_visible
        expect(users.message.modal.text).to eql 'Your password must include letters and numbers. Please try again.'
        users.message.btn_ok.click
      end
      
    end
    after do
      users.details_pass.txt_massive_pass.set('123456asd')
      users.details_pass.btn_save.click
      #users.message.wait_until_modal_visible
      #expect(users.message.modal.text).to eql ''
      users.message.btn_ok.click
    end
  end

  after(:each) do |e|
    e.attach_file('screenshot', get_screenshot)
    Capybara.current_session.driver.quit
  end
end
