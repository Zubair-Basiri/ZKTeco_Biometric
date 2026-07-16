"use client";

import { PaginatedTable } from "@/components/paginated-table";
import { StatusBadge } from "@/components/status-badge";
import { formatDateTime } from "@/lib/helpers";

export type EmployeeDirectoryRow = {
  id: string;
  name: string;
  employeeCode: string;
  biometricUid: string | null;
  deviceUid: number | null;
  deviceRole: number | null;
  deviceCardNo: number | null;
  department: string | null;
  designation: string | null;
  isActive: boolean;
  attendanceCount: number;
  lastAttendanceAt: Date | string | null;
  lastDeviceName: string | null;
};

type EmployeeDirectoryTableProps = {
  employees: EmployeeDirectoryRow[];
};

export function EmployeeDirectoryTable({ employees }: EmployeeDirectoryTableProps) {
  return (
    <PaginatedTable
      rows={employees}
      pageSize={8}
      getKey={(employee) => employee.id}
      header={
        <tr>
          <th className="px-3 py-3">Name</th>
          <th className="px-3 py-3">Code</th>
          <th className="px-3 py-3">Biometric UID</th>
          <th className="px-3 py-3">Device UID</th>
          <th className="px-3 py-3">Role</th>
          <th className="px-3 py-3">Card</th>
          <th className="px-3 py-3">Department</th>
          <th className="px-3 py-3">Designation</th>
          <th className="px-3 py-3">Attendance count</th>
          <th className="px-3 py-3">Last attendance</th>
          <th className="px-3 py-3">Device</th>
          <th className="px-3 py-3">Status</th>
        </tr>
      }
      emptyState={
        <tr>
          <td colSpan={12} className="px-3 py-10 text-center text-sm text-slate-500">
            No mirrored device users found yet.
          </td>
        </tr>
      }
      mobileEmptyState={
        <div className="rounded-[24px] border border-stone-200 bg-white px-4 py-8 text-center text-sm text-slate-500">
          No mirrored device users found yet.
        </div>
      }
      renderRow={(employee) => (
        <>
          <td className="px-3 py-4">
            <div>
              <p className="font-medium text-slate-950">{employee.name}</p>
              <p className="mt-1 text-xs text-slate-500">{employee.designation || "No title set"}</p>
            </div>
          </td>
          <td className="px-3 py-4 font-medium text-slate-900">{employee.employeeCode}</td>
          <td className="px-3 py-4">{employee.biometricUid || "-"}</td>
          <td className="px-3 py-4">{employee.deviceUid ?? "-"}</td>
          <td className="px-3 py-4">{employee.deviceRole ?? "-"}</td>
          <td className="px-3 py-4">{employee.deviceCardNo ?? "-"}</td>
          <td className="px-3 py-4">{employee.department || "-"}</td>
          <td className="px-3 py-4">{employee.designation || "-"}</td>
          <td className="px-3 py-4">{employee.attendanceCount}</td>
          <td className="px-3 py-4">
            {employee.lastAttendanceAt ? formatDateTime(employee.lastAttendanceAt) : "No records yet"}
          </td>
          <td className="px-3 py-4">{employee.lastDeviceName || "-"}</td>
          <td className="px-3 py-4">
            <StatusBadge label={employee.isActive ? "ACTIVE" : "INACTIVE"} />
          </td>
        </>
      )}
      renderMobileCard={(employee) => (
        <div className="space-y-3 text-sm text-slate-700">
          <div className="flex items-start justify-between gap-3">
            <div>
              <p className="font-medium text-slate-950">{employee.name}</p>
              <p className="mt-1 text-xs uppercase tracking-[0.15em] text-slate-500">
                {employee.employeeCode}
              </p>
            </div>
            <StatusBadge label={employee.isActive ? "ACTIVE" : "INACTIVE"} />
          </div>

          <div className="grid grid-cols-2 gap-2 text-xs text-slate-600">
            <p>Biometric UID: {employee.biometricUid || "-"}</p>
            <p>Device UID: {employee.deviceUid ?? "-"}</p>
            <p>Role: {employee.deviceRole ?? "-"}</p>
            <p>Card: {employee.deviceCardNo ?? "-"}</p>
          </div>

          <div className="rounded-2xl bg-stone-50 px-3 py-2 text-xs text-slate-600">
            <p>Department: {employee.department || "-"}</p>
            <p className="mt-1">Last attendance: {employee.lastAttendanceAt ? formatDateTime(employee.lastAttendanceAt) : "No records yet"}</p>
          </div>
        </div>
      )}
    />
  );
}