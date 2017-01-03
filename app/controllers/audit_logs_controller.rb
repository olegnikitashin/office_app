class AuditLogsController < ApplicationController
  def index
    @audit_logs = AuditLog.all.page(params[:page]).per(10).order(created_at: :desc)
    authorize @audit_logs
  end
end
