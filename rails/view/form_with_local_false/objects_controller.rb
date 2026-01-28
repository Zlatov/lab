class Admin::ObjectsController < Admin::ApplicationController

  def create
    @admin_object = Admin::Object.new(admin_object_params)

    respond_to do |format|
      if @admin_object.save
        flash[:notice] = @notice
        format.html { redirect_to admin_object_url(@admin_object) }
        format.js { render js: "window.location = '#{admin_object_url(@admin_object)}'" }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.js { render :new, status: :unprocessable_entity }
      end
    end
  end

  def update
    respond_to do |format|
      if @admin_object.update(admin_object_params)
        flash[:notice] = @notice
        format.html { redirect_to admin_object_url(@admin_object) }
        format.js { render js: "window.location = '#{admin_object_url(@admin_object)}'" }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.js { render :edit, status: :unprocessable_entity }
      end
    end
  end
end
