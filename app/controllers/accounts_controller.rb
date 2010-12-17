class AccountsController < ApplicationController
  before_filter :require_admin
  def index
    params[:name].blank? ? @accounts = Account.paginate( :page => params[:page], :per_page => 20 ) : @accounts = Account.any_of({:name => /.*#{params[:name]}.*/mi}).order_by([[:name, :asc]]).paginate( :page => params[:page], :per_page => 20 )
    if @accounts.blank? && !params[:name].blank? 
      @accounts = @accounts = Account.any_of({:name => /.*#{params[:name]}.*/mi}).order_by([[:name, :asc]]).paginate( :page => params[:page], :per_page => 20 )
    end
  end
  
  def show
    @account = Account.find(params[:id])
  end
  
  def refresh
    @account = Account.find(params[:id])
    @account.sync_contacts
    redirect_to @account
  end
  
  def new
    @account = Account.new
  end
  
  def create
    @account = Account.new(params[:account])
    if @account.save
      flash[:notice] = "Successfully created account."
      redirect_to @account
    else
      render :action => 'new'
    end
  end
  
  def edit
    @account = Account.find(params[:id])
  end
  
  def update
    @account = Account.find(params[:id])
    if @account.update_attributes(params[:account])
      flash[:notice] = "Successfully updated account."
      redirect_to @account
    else
      render :action => 'edit'
    end
  end
  
  def destroy
    @account = Account.find(params[:id])
    @account.destroy
    flash[:notice] = "Successfully destroyed account."
    redirect_to accounts_url
  end
end
