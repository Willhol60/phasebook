class PagesController < ApplicationController
  skip_before_action :authenticate_user!, only: :home

  def index
    @user = current_user
    @readings = Reading.where("user_id = ?", params[:user_id])
  end

  def profile
    @user = current_user
  end

  # def books_read
  #   return unless @reading.read_status == 'Future'

  #   total = 0
  #   @readings.each do |reading|
  #     books = reading.book.count
  #     total += books
  #   end
  # end

  # def time_spent
  #   time = 0
  #   @readings.each do |reading|
  #     duration = reading.end_date - reading.start_date
  #     time += duration
  #   end
  #   return time
  # end

  # def avg_speed
  #   time_spent / books_read
  # end

  # def categories
  #   total = 0
  #   @readings.each do |reading|
  #     cat = reading.book.category.count
  #     total += cat
  #   end
  # end
end
