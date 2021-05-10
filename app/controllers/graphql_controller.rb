class GraphqlController < ApplicationController
  def execute
    variables = ensure_hash(params[:variables])
    query = params[:query]
    operation_name = params[:operationName]
    context = {
      # we need to provide session and current user
      
      current_user: current_user
    }
    result = DoctorPatientGraphqlSchema.execute(query, variables: variables, context: context, operation_name: operation_name)
    render json: result
  rescue => e
    raise e unless Rails.env.development?
    handle_error_in_development e
  end

  private

  # gets current user from token stored in the session
  
  # Handle form data, JSON body, or a blank value
  def ensure_hash(ambiguous_param)
    # ...code
  end

  def handle_error_in_development(e)
    # ...code
  end
end