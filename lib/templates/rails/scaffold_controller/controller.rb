<% if namespaced? -%>
require_dependency "<%= namespaced_path %>/application_controller"
<% end -%>
<% module_namespacing do -%>
class <%= controller_class_name %>Controller < ApplicationController
  before_action :set_model, only: [:destroy, :update, :show, :edit]
  before_action :authorize_admin

  def index
    @<%= plural_table_name %> = <%= orm_class.all(class_name) %>
  end

  def show
  end

  def new
    @<%= singular_table_name %> = <%= orm_class.build(class_name) %>
  end

  def edit
  end


  def create
    @<%= singular_table_name %> = <%= orm_class.build(class_name, "#{singular_table_name}_params") %>

    if @<%= orm_instance.save %>
      redirect_to @<%= singular_table_name %>
    else
      render :new
    end
  end

  def update
    if @<%= orm_instance.update("#{singular_table_name}_params") %>
      redirect_to @<%= singular_table_name %>
    else
      render :edit
    end
  end

  def destroy
    @<%= orm_instance.destroy %>

    redirect_to <%= index_helper %>_url
  end

  def set_model
    @<%= singular_table_name %> = <%= orm_class.find(class_name, "params[:id]") %>
  end

  private

  def <%= "#{singular_table_name}_params" %>
    <%- if attributes_names.empty? -%>
    params.fetch(:<%= singular_table_name %>, {})
    <%- else -%>
    params.require(:<%= singular_table_name %>).permit(<%= attributes_names.map { |name| ":#{name}" }.join(', ') %>)
    <%- end -%>
  end
end
<% end -%>
