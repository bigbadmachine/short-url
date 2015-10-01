class LinksController < ApplicationController
  
  def new
    @link = Link.new
  end

  def show
    if @link = Link.find_by(token: params[:token])
      # do a 301 redirect to the destination url
      redirect_to @link.url, status: :moved_permanently
    else
      redirect_to LinkShortener.default_link, flash: {error: "Invalid link!"}
    end
  end

  def create
    url = LinkShortener.clean_url( params[:link][:url] )
    @link = Link.where( url: url ).first_or_create
    if @link.errors.messages.blank?
      @recent_link = @link
    else
      flash.now[:error] = @link.errors.full_messages.to_sentence
    end
    @link = Link.new
    render action: :new
  end

end
