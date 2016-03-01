Deface::Override.new(:virtual_path=>'spree/admin/shared/_main_menu',
                     :name => 'add_contest_to_menu_bar',
                     :insert_after =>"erb[silent]:contains('current_store')~erb[silent]",
                     :text         =>"<ul class='nav nav-sidebar'>
                                       <%= tab 'concours', url: spree.admin_contests_path, icon: 'user' %>
                                      </ul>")