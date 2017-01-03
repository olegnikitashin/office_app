class AuditLogsController < ApplicationController
  def index
    @audit_logs = AuditLog.all.order(created_at: :desc)
    authorize @audit_logs
  end
end
