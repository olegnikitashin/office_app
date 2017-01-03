class AuditLogsController < ApplicationController
  def index
    @audit_logs = AuditLog.all.page(params[:page]).per(10).order(created_at: :desc)
    authorize @audit_logs
  end

  def confirm
    audit_log = AuditLog.find(params[:id])
    authorize audit_log
    audit_log.confirmed!
    flash[:notice] = 'The audit log has been confirmed!'
    redirect_to root_path
  end
end
