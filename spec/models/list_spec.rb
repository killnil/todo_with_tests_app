require 'rails_helper'

RSpec.describe List, type: :model do
  describe '#complete_all_tasks!' do 
    it 'should mark all tasks from the list as complete' do 
      list = List.create(name: "Chores")
      Task.create(complete: false, list_id: list.id, name: "Take out papers")
      Task.create(complete: false, list_id: list.id, name: "Take out trash")
      Task.create(complete: true,  list_id: list.id, name: "Spend some spending cash")

      list.complete_all_tasks!

      expect(list.tasks[0].complete).to eq(true)
      expect(list.tasks[1].complete).to eq(true)
      expect(list.tasks[2].complete).to eq(true)
    end
  end

  describe '#snooze_all_tasks!' do
    it 'should snooze each task in the list' do 
      list = List.create(name: "Favorite Things")

      task_info = [
                   {name: "Raindrops on Roses", timestamp: Time.now },
                   {name: "Whiskers on Kittens", timestamp: 23.days.from_now },
                   {name: "Bright Copper Kettles", timestamp: 56.seconds.ago }
                  ]

      task_info.each do |data|
        Task.create(list_id: list.id, name: data[:name], deadline: data[:timestamp])
      end

      list.snooze_all_tasks!

      list.tasks.length.times do |index|
        expect(list.tasks[index].deadline).to eq(task_info[index][:timestamp] + 1.hour)
      end
    end
  end

  describe '#total_duration' do 
    it 'should return the sum of the duration from each task on this list' do
      list = List.create(name: "Assignments")
      Task.create(name: "walk a mile in someone's shoes", duration: 15, list_id: list.id)
      Task.create(name: "whittle a toothpick", duration: 30, list_id: list.id)
      Task.create(name: "solve world peace", duration: 2, list_id: list.id)

      expect(list.total_duration).to eq(47)
    end
  end

  describe '#incomplete_tasks' do 
    it 'should return a collection of all incomplete tasks associated with list' do 
      list = List.create(name: "Shoe's to wear")
      task_1 = Task.create(name: "High tops", complete: true, list_id: list.id)
      task_2 = Task.create(name: "Pumps", complete: false, list_id: list.id)
      task_3 = Task.create(name: "Flip flops", complete: true, list_id: list.id)
      task_4 = Task.create(name: "Loafers", complete: false, list_id: list.id)

      list.incomplete_tasks.each do |task|
        expect(task.complete).to eq(false)
      end

      expect(list.incomplete_tasks.length).to eq(2)

      expect(list.incomplete_tasks).to match_array([task_4, task_2])
    end
  end

  describe '#favorite_tasks' do 
    it 'should return a collection of all favorite tasks associated with list' do 
      list = List.create(name: "Shoe's to wear")
      task_1 = Task.create(name: "High tops", favorite: true, list_id: list.id)
      task_2 = Task.create(name: "Pumps", favorite: false, list_id: list.id)
      task_3 = Task.create(name: "Loafers", favorite: false, list_id: list.id)
      task_4 = Task.create(name: "Flip flops", favorite: true, list_id: list.id)

      list.favorite_tasks.each do |task|
        expect(task.favorite).to eq(true)
      end

      expect(list.favorite_tasks.length).to eq(2)

      expect(list.favorite_tasks).to match_array([task_1, task_4])
    end
  end
end























