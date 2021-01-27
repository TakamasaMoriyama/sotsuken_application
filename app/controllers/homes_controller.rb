class HomesController < ApplicationController
  def index
    @logs = Log.all.order(created_at: :desc).page(params[:page]).per(2)
  end

  def new
  end

  def show
#以下通常検索
    @log2 = Log.find(params[:id])
    @select_name = []
    @select_name2 = []
    @select_event_context = []
    @select_event_context2 = []
    @select_event = []
    @select_event2 = []
    if params[:select_name].present? || params[:select_event_context].present? || params[:select_event].present?
      binding.pry
      if params[:select_name].present? && params[:select_event_context].present? && params[:select_event].present?
        @log = Log.find(params[:id]).elements.where(name: params[:select_name], event_context: params[:select_event_context], event: params[:select_event])
      elsif params[:select_name].present? && params[:select_event_context].present?
        @log = Log.find(params[:id]).elements.where(name: params[:select_name], event_context: params[:select_event_context])
      elsif params[:select_name].present? && params[:select_event].present?
        @log = Log.find(params[:id]).elements.where(name: params[:select_name], event: params[:select_event])
      elsif params[:select_event].present? && params[:select_event_context].present?
        @log = Log.find(params[:id]).elements.where(event: params[:select_event], event_context: params[:select_event_context])
      elsif params[:select_name].present?
        @log = Log.find(params[:id]).elements.where(name: params[:select_name])
      elsif params[:select_event_context].present?
        @log = Log.find(params[:id]).elements.where(event_context: params[:select_event_context])
      elsif params[:select_event].present?
        @log = Log.find(params[:id]).elements.where(event: params[:select_event])
      else
        @log = @log2 if @log.nil?
      end
    end

#以下not検索
    if params[:not_select_name].present? || params[:not_select_event_context].present? || params[:not_select_event].present?
      if params[:not_select_name].present? && params[:not_select_event_context].present? && params[:not_select_event].present?
        @log = Log.find(params[:id]).elements.where.not(name: params[:not_select_name], event_context: params[:not_select_event_context], event: params[:not_select_event])
      elsif params[:not_select_name].present? && params[:not_select_event_context].present?
        @log = Log.find(params[:id]).elements.where.not(name: params[:not_select_name], event_context: params[:not_select_event_context])
      elsif params[:not_select_name].present? && params[:not_select_event].present?
        @log = Log.find(params[:id]).elements.where.not(name: params[:not_select_name], event: params[:not_select_event])
      elsif params[:not_select_event].present? && params[:not_select_event_context].present?
        @log = Log.find(params[:id]).elements.where.not(event: params[:not_select_event], event_context: params[:not_select_event_context])
      elsif params[:not_select_name].present?
        @log = Log.find(params[:id]).elements.where.not(name: params[:not_select_name])
      elsif params[:not_select_event_context].present?
        @log = Log.find(params[:id]).elements.where.not(event_context: params[:not_select_event_context])
      elsif params[:not_select_event].present?
        @log = Log.find(params[:id]).elements.where.not(event: params[:not_select_event])
      end
    else
      @log = @log2 if @log.nil?
    end



    @log2.elements.each do |element|
      unless @select_name.include? element.name
        @select_name << element.name
      end
      unless @select_event_context.include? element.event_context
        @select_event_context << element.event_context
      end
      unless @select_event.include? element.event
        @select_event << element.event
      end
    end
    @select_name2 << ["名前", nil]
    @select_event_context2 << ["イベントコンテキスト", nil]
    @select_event2 << ["イベント", nil]
    @select_name.each do |select_name|
      @select_name2 << [select_name, select_name]
    end
    @select_event_context.each do |select_name|
      @select_event_context2 << [select_name, select_name]
    end
    @select_event.each do |select_name|
      @select_event2 << [select_name, select_name]
    end
  end

  def create
    log = Log.create(name: params[:logs][:name])

    CSV.foreach(params[:csv_file].path, headers: true) do |row|
      elements = Element.new
      elements.log_id = log.id
      elements.time = row[0]
      elements.name = row[1]
      elements.event_context = row[3]
      elements.event = row[5]
      elements.save
    end
    redirect_to "/"
  end

  def update
  end

  def destroy
    log = Log.find(params[:id])
    log.destroy
    redirect_to "/"
  end
end
