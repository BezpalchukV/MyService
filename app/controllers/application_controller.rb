class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  require 'open-uri'
  require 'nokogiri'

  def blogservice
    source = 'http://waitbutwhy.com'

    # получаем содержимое веб-страницы в объект
    page = Nokogiri::HTML(open(source.to_s + page))
    i=0
    # производим поиск по элементам с помощью css-выборки
    page.css('#menu-primary-navigation').each do |link|

      @category = Hash.new

      @category[i]['text'] = link.content

      @category[i]['href'] = link['href']
      i=i+1;

    end
   @category
  end

  helper_method :blogservice

end
