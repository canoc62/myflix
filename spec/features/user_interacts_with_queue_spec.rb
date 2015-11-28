require 'spec_helper'
require 'pry'

feature "User interacts with the queue" do
  scenario "user adds and reorders videos in the queue" do
    anime = Fabricate(:category, name: "Anime")
    video_1 = Fabricate(:video, title: "Dragonball", category: anime)
    video_2 = Fabricate(:video, title: "Pokemon", category: anime)
    video_3 = Fabricate(:video, title: "Digimon", category: anime)

    sign_in
    
    add_video_to_queue(video_1)
    expect_video_to_be_in_queue(video_1)

    visit video_path(video_1)
    expect_link_to_not_be_seen("+ My Queue")

    add_video_to_queue(video_2)
    add_video_to_queue(video_3)

    set_video_position(video_1, 3)
    set_video_position(video_2, 1)
    set_video_position(video_3, 2)
     
    update_queue

    expect_video_position(video_1, 3)
    expect_video_position(video_2, 1)
    expect_video_position(video_3, 2)
    
  end

  def expect_video_position(video, position)
    expect(find(:xpath, "//tr[contains(.,'#{video.title}')]//input[@type='text']").value).to eq(position.to_s)
  end

  def set_video_position(video, position)
    within(:xpath, "//tr[contains(.,'#{video.title}')]") do
      fill_in "queue_items[][position]", with: position
    end
  end

  def add_video_to_queue(video)
    visit home_path
    find("a[href='/videos/#{video.id}']").click
    click_link "+ My Queue"
  end

  def expect_video_to_be_in_queue(video)
    page.should have_content(video.title)
  end

  def expect_link_to_not_be_seen(link)
    page.should_not have_content link
  end

  def update_queue
    click_button "Update Instant Queue"
  end
end