# Api::V1::ApplicationController is in the starter repository and isn't
# needed for this package's unit tests, but our CI tests will try to load this
# class because eager loading is set to `true` when CI=true.
# We wrap this class in an `if` statement to circumvent this issue.
if defined?(Api::V1::ApplicationController)
  class Api::V1::TreasureHuntsController < Api::V1::ApplicationController
    account_load_and_authorize_resource :treasure_hunt, through: :team, through_association: :treasure_hunts

    # GET /api/v1/teams/:team_id/treasure_hunts
    def index
    end

    # GET /api/v1/treasure_hunts/:id
    def show
    end

    # POST /api/v1/teams/:team_id/treasure_hunts
    def create
      if @treasure_hunt.save
        render :show, status: :created, location: [:api, :v1, @treasure_hunt]
      else
        render json: @treasure_hunt.errors, status: :unprocessable_entity
      end
    end

    # PATCH/PUT /api/v1/treasure_hunts/:id
    def update
      if @treasure_hunt.update(treasure_hunt_params)
        render :show
      else
        render json: @treasure_hunt.errors, status: :unprocessable_entity
      end
    end

    # DELETE /api/v1/treasure_hunts/:id
    def destroy
      @treasure_hunt.destroy
    end

    private

    module StrongParameters
      # Only allow a list of trusted parameters through.
      def treasure_hunt_params
        strong_params = params.require(:treasure_hunt).permit(
          *permitted_fields,
          :name,
          :starts_at,
          :ends_at,
          :call_to_action,
          :incentive,
          :allow_image,
          # 🚅 super scaffolding will insert new fields above this line.
          *permitted_arrays,
          # 🚅 super scaffolding will insert new arrays above this line.
        )

        process_params(strong_params)

        strong_params
      end
    end

    include StrongParameters
  end
else
  class Api::V1::TreasureHuntsController
  end
end
