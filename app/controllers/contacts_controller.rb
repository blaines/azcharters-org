class ContactsController < ApplicationController
  before_filter :require_admin
  
  def index
    @contacts = Contact.order_by([[:name, :asc]]).paginate :page => params[:page], :per_page => 20
  end
  
  def show
    @contact = Contact.find(params[:id])
  end
  
  def new
    @contact = Contact.new
  end
  
  def create
    @contact = Contact.new(params[:contact])
    if @contact.save
      flash[:notice] = "Successfully created contact."
      redirect_to @contact
    else
      render :action => 'new'
    end
  end
  
  def edit
    @contact = Contact.find(params[:id])
  end
  
  def update
    @contact = Contact.find(params[:id])
    if @contact.update_attributes(params[:contact])
      flash[:notice] = "Successfully updated contact."
      redirect_to @contact
    else
      render :action => 'edit'
    end
  end
  
  def destroy
    @contact = Contact.find(params[:id])
    @contact.destroy
    flash[:notice] = "Successfully destroyed contact."
    redirect_to contacts_url
  end
  
  def invite
    @contact = Contact.find(params[:id])
    
    unless @contact.email.blank?
      @user = User.invite(:email => @contact.email, :name => @contact.name, :contact_id => @contact.id)
      flash[:notice] = "Invited #{@contact.name}."
      redirect_to @contact
    else
      flash[:notice] = "Email address required to invite user."
      redirect_to @contact
    end
  end
end
