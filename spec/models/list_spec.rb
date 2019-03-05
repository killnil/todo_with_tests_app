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
end
