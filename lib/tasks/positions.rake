namespace :positions do
  desc "TODO"
  task positions: :environment do
    to_update = Video.where(position: nil)
    to_update.each do |video|
      video.update(position: 0)
      end
    puts "All nil positions assigned to 0"
  end

end
