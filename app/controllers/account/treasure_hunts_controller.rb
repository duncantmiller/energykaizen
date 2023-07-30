class Account::TreasureHuntsController < Account::ApplicationController
  account_load_and_authorize_resource :treasure_hunt, through: :team, through_association: :treasure_hunts

  # GET /account/teams/:team_id/treasure_hunts
  # GET /account/teams/:team_id/treasure_hunts.json
  def index
    delegate_json_to_api
  end

  # GET /account/treasure_hunts/:id
  # GET /account/treasure_hunts/:id.json
  def show
    delegate_json_to_api
  end

  # GET /account/teams/:team_id/treasure_hunts/new
  def new
  end

  # GET /account/treasure_hunts/:id/edit
  def edit
  end

  # POST /account/teams/:team_id/treasure_hunts
  # POST /account/teams/:team_id/treasure_hunts.json
  def create
    respond_to do |format|
      if @treasure_hunt.save
        format.html { redirect_to [:account, @treasure_hunt], notice: I18n.t("treasure_hunts.notifications.created") }
        format.json { render :show, status: :created, location: [:account, @treasure_hunt] }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @treasure_hunt.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /account/treasure_hunts/:id
  # PATCH/PUT /account/treasure_hunts/:id.json
  def update
    respond_to do |format|
      if @treasure_hunt.update(treasure_hunt_params)
        format.html { redirect_to [:account, @treasure_hunt], notice: I18n.t("treasure_hunts.notifications.updated") }
        format.json { render :show, status: :ok, location: [:account, @treasure_hunt] }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @treasure_hunt.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /account/treasure_hunts/:id
  # DELETE /account/treasure_hunts/:id.json
  def destroy
    @treasure_hunt.destroy
    respond_to do |format|
      format.html { redirect_to [:account, @team, :treasure_hunts], notice: I18n.t("treasure_hunts.notifications.destroyed") }
      format.json { head :no_content }
    end
  end

  private

  if defined?(Api::V1::ApplicationController)
    include strong_parameters_from_api
  end

  def process_params(strong_params)
    assign_date(strong_params, :starts_at)
    assign_date(strong_params, :ends_at)
    # 🚅 super scaffolding will insert processing for new fields above this line.
  end
end
