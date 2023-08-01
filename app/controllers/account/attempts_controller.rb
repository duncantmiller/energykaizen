class Account::AttemptsController < Account::ApplicationController
  account_load_and_authorize_resource :attempt, through: :treasure_hunt, through_association: :attempts

  # GET /account/treasure_hunts/:treasure_hunt_id/attempts
  # GET /account/treasure_hunts/:treasure_hunt_id/attempts.json
  def index
    delegate_json_to_api
  end

  # GET /account/attempts/:id
  # GET /account/attempts/:id.json
  def show
    delegate_json_to_api
  end

  # GET /account/treasure_hunts/:treasure_hunt_id/attempts/new
  def new
  end

  # GET /account/attempts/:id/edit
  def edit
  end

  # POST /account/treasure_hunts/:treasure_hunt_id/attempts
  # POST /account/treasure_hunts/:treasure_hunt_id/attempts.json
  def create
    respond_to do |format|
      if @attempt.save
        format.html { redirect_to [:account, @attempt], notice: I18n.t("attempts.notifications.created") }
        format.json { render :show, status: :created, location: [:account, @attempt] }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @attempt.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /account/attempts/:id
  # PATCH/PUT /account/attempts/:id.json
  def update
    respond_to do |format|
      if @attempt.update(attempt_params)
        format.html { redirect_to [:account, @attempt], notice: I18n.t("attempts.notifications.updated") }
        format.json { render :show, status: :ok, location: [:account, @attempt] }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @attempt.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /account/attempts/:id
  # DELETE /account/attempts/:id.json
  def destroy
    @attempt.destroy
    respond_to do |format|
      format.html { redirect_to [:account, @treasure_hunt, :attempts], notice: I18n.t("attempts.notifications.destroyed") }
      format.json { head :no_content }
    end
  end

  private

  if defined?(Api::V1::ApplicationController)
    include strong_parameters_from_api
  end

  def process_params(strong_params)
    # 🚅 super scaffolding will insert processing for new fields above this line.
  end
end
