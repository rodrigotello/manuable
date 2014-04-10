json.partial! '/api/events/event', collection: @events, as: :event, includes: params[:includes]
