namespace :hunt_topic_builder do
  desc "add or hunt topics and ideas"
  hunt_topic_names = [
    "Lighting", "Compressed Air Systems", "Motors", "Steam Systems", "Pumping Systems", "Fan Systems"
  ]
  task build_all: :environment do
    Idea.destroy_all
    HuntTopic.destroy_all
    puts "starting hunt topics: #{HuntTopic.all.size}"
    puts "starting ideas: #{Idea.all.size}"
    generate_pumping_systems
    puts "ending hunt topics: #{HuntTopic.all.size}"
    puts "ending ideas: #{Idea.all.size}"
  end

  def generate_pumping_systems
    hunt_topic = HuntTopic.create!(name: "Pumping Systems", slot: 4)
    Idea.create!(
      name: "Can pump running hours be reduced?",
      indicator: "Running (when not needed) on holidays, weekends, nights, too long before shift, finishes too long after shift, breaks; running continuously where loads are irregular (batch ops, irregularly used services)",
      slot: 0,
      hunt_topic: hunt_topic
    )
    Idea.create!(
      name: "Are there opportunities to use pressure switches to control the number of pumps in service when flow rate requirements vary?",
      slot: 1,
      hunt_topic: hunt_topic
    )
    Idea.create!(
      name: "Can existing pump drive motors be replaced with high-efficiency motors?",
      indicator: "Below 60% efficiency (doesn't apply to pump systems with solids)",
      slot: 2,
      hunt_topic: hunt_topic
    )
    Idea.create!(
      name: "Are there opportunities to replace oversized pumps with properly sized pumps or change pump impellers?",
      indicator: "Cavitating equipment, high maintenance requirements, noisy pumps, or piping; worn/eroded/corroded/distorted or broken impellers/vanes or wear rings",
      slot: 3,
      hunt_topic: hunt_topic
    )
    Idea.create!(
      name: "Can variable flow rate requirements be met with an adjustable speed drive or multiple pump arrangement instead of throttling or bypassing excess flow?",
      indicator: "Constant throttling",
      slot: 4,
      hunt_topic: hunt_topic
    )
  end
end
