module GroupsHelper
  def current_group_id
    @group ? @group.id : ""
  end
end
