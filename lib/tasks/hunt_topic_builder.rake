namespace :hunt_topic_builder do
  desc "add or hunt topics and ideas"
  hunt_topic_names = [
    "Lighting", "Compressed Air Systems", "Motors", "Steam Systems", "Pumping Systems", "Fan Systems"
  ]
  task build_all: :environment do
    ## remove this once we start collecting data
    Idea.destroy_all
    HuntTopic.destroy_all
    ####

    puts "starting hunt topics: #{HuntTopic.all.size}"
    puts "starting ideas: #{Idea.all.size}"
    generate_pumping_systems
    generate_lighting
    puts "ending hunt topics: #{HuntTopic.all.size}"
    puts "ending ideas: #{Idea.all.size}"
  end

  def generate
    hunt_topic = HuntTopic.create!(name: "Lighting", slot: 0)
    Idea.create!(
      name: ,
      indicator: ,
      slot: 0,
      hunt_topic: hunt_topic
    )
    Idea.create!(
      name: ,
      indicator: ,
      slot: 1,
      hunt_topic: hunt_topic
    )
    Idea.create!(
      name: ,
      indicator: ,
      slot: 2,
      hunt_topic: hunt_topic
    )
    Idea.create!(
      name: ,
      indicator: ,
      slot: 3,
      hunt_topic: hunt_topic
    )
    Idea.create!(
      name: ,
      indicator: ,
      slot: 4,
      hunt_topic: hunt_topic
    )
  end

  def generate_lighting
    hunt_topic = HuntTopic.create!(name: "Lighting", slot: 0)
    Idea.create!(
      name: "Can lighting levels be reduced in any area of the site?",
      slot: 0,
      hunt_topic: hunt_topic
    )
    Idea.create!(
      name: "Can lighting hours be reduced in any area of the site?",
      slot: 1,
      hunt_topic: hunt_topic
    )
    Idea.create!(
      name: "Can lamps be removed in any area of the site?",
      slot: 2,
      hunt_topic: hunt_topic
    )
    Idea.create!(
      name: "Are there areas where lights aren't being turned off even when they're not needed (i.e. no employees present, production stopped, no security need)?",
      slot: 3,
      hunt_topic: hunt_topic
    )
    Idea.create!(
      name: "Can motion sensor lighting controls be employed in any area of the site where occupancy is intermittent or infrequent?",
      slot: 4,
      hunt_topic: hunt_topic
    )
    Idea.create!(
      name: "Can any lighting systems be upgraded to more energy efficient bulbs? , Can exterior lighting levels be reduced to minimum safe levels?",
      slot: 5,
      hunt_topic: hunt_topic
    )
    Idea.create!(
      name: "Is there an opportunity to reduce exterior lighting hours by using timers or photocells to turn off when daylight permits?",
      slot: 6,
      hunt_topic: hunt_topic
    )
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
