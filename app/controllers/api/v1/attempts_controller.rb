# Api::V1::ApplicationController is in the starter repository and isn't
# needed for this package's unit tests, but our CI tests will try to load this
# class because eager loading is set to `true` when CI=true.
# We wrap this class in an `if` statement to circumvent this issue.
if defined?(Api::V1::ApplicationController)
  class Api::V1::AttemptsController < Api::V1::ApplicationController
    account_load_and_authorize_resource :attempt, through: :treasure_hunt, through_association: :attempts

    # GET /api/v1/treasure_hunts/:treasure_hunt_id/attempts
    def index
    end

    # GET /api/v1/attempts/:id
    def show
    end

    # POST /api/v1/treasure_hunts/:treasure_hunt_id/attempts
    def create
      if @attempt.save
        render :show, status: :created, location: [:api, :v1, @attempt]
      else
        render json: @attempt.errors, status: :unprocessable_entity
      end
    end

    # PATCH/PUT /api/v1/attempts/:id
    def update
      if @attempt.update(attempt_params)
        render :show
      else
        render json: @attempt.errors, status: :unprocessable_entity
      end
    end

    # DELETE /api/v1/attempts/:id
    def destroy
      @attempt.destroy
    end

    private

    module StrongParameters
      # Only allow a list of trusted parameters through.
      def attempt_params
        strong_params = params.require(:attempt).permit(
          *permitted_fields,
          :first_name,
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
  class Api::V1::AttemptsController
  end
end
