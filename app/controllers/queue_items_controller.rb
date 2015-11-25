class QueueItemsController < ApplicationController
  before_filter :require_user

  def index
    @queue_items = current_user.queue_items
  end

  def create
    video = Video.find(params[:video_id])

    if !current_user_queued_video?(video)
      queue_video(video)
    end
    
    redirect_to my_queue_path
  end

  def destroy

    queue_item = QueueItem.find(params[:id])
    queue_item.destroy if current_user.queue_items.include?(queue_item)
    redirect_to my_queue_path
  end

  private

  def new_queue_item_position
    current_user.queue_items.count + 1
  end

  def current_user_queued_video?(video)
    current_user.queue_items.map(&:video).include?(video)
  end

  def queue_video(video)
    QueueItem.create(user: current_user, video: video, position: new_queue_item_position)
  end

end