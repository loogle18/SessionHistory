class SessionHistoriesController < ApplicationController
  def index
    @histories = History.all
  end
end
