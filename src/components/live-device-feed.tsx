"use client";

import { useEffect, useEffectEvent, useRef, useState } from "react";
import { CheckCircle2, Fingerprint, Router, X } from "lucide-react";
import { PaginatedTable } from "@/components/paginated-table";
import { formatDateTime, formatRelativeTime } from "@/lib/helpers";
import { StatusBadge } from "@/components/status-badge";

type LiveDeviceStatus = {
  id: string;
  name: string;
  ipAddress: string;
  location: string | null;
  status: string;
  lastSeenAt: string | Date | null;
  lastSyncAt: string | Date | null;
};

type LivePunch = {
  id: string;
  employeeName: string;
  employeeCode: string;
  biometricUid: string;
  deviceUid: number | null;
  deviceRole: number | null;
  deviceCardNo: number | null;
  department: string | null;
  designation: string | null;
  occurredAt: string | Date;
  deviceName: string;
  deviceIp: string | null;
  deviceStatus: string;
  verificationType: string | null;
};

type LiveDeviceFeedProps = {
  initialData: {
    devices: LiveDeviceStatus[];
    recentPunches: LivePunch[];
  };
};

export function LiveDeviceFeed({ initialData }: LiveDeviceFeedProps) {
  const [data, setData] = useState(initialData);
  const [successPunch, setSuccessPunch] = useState<LivePunch | null>(null);
  const topPunchRef = useRef<string | null>(initialData.recentPunches[0]?.id ?? null);
  const hasCompletedRefreshRef = useRef(false);

  const refresh = useEffectEvent(async () => {
    const response = await fetch("/api/live", { cache: "no-store" });

    if (!response.ok) {
      return;
    }

    const next = (await response.json()) as LiveDeviceFeedProps["initialData"];
    const nextTopPunchId = next.recentPunches[0]?.id ?? null;

    if (
      hasCompletedRefreshRef.current &&
      nextTopPunchId &&
      nextTopPunchId !== topPunchRef.current
    ) {
      setSuccessPunch(next.recentPunches[0] ?? null);
    }

    topPunchRef.current = nextTopPunchId;
    hasCompletedRefreshRef.current = true;
    setData(next);
  });

  useEffect(() => {
    const initialTimeoutId = window.setTimeout(() => {
      void refresh();
    }, 0);

    const intervalId = window.setInterval(() => {
      void refresh();
    }, 1_500);

    return () => {
      window.clearTimeout(initialTimeoutId);
      window.clearInterval(intervalId);
    };
  }, []);

  useEffect(() => {
    if (!successPunch) return;

    const timer = window.setTimeout(() => {
      setSuccessPunch(null);
    }, 3_000);

    return () => {
      window.clearTimeout(timer);
    };
  }, [successPunch]);

  return (
    <>
      {successPunch ? (
        <div className="fixed inset-0 z-40 flex items-center justify-center bg-slate-950/35 px-4 py-6 backdrop-blur-sm">
          <div className="w-full max-w-md rounded-[28px] border border-emerald-200 bg-white p-6 shadow-[0_28px_90px_rgba(15,23,32,0.18)]">
            <div className="flex items-start justify-between gap-4">
              <div className="flex items-start gap-3">
                <div className="rounded-2xl bg-emerald-100 p-3 text-emerald-700">
                  <CheckCircle2 className="h-5 w-5" />
                </div>
                <div>
                  <p className="text-xs uppercase tracking-[0.18em] text-emerald-700">Attendance success</p>
                  <h3 className="mt-1 text-xl font-semibold tracking-tight text-slate-950">
                    Fingerprint captured
                  </h3>
                </div>
              </div>
              <button
                type="button"
                onClick={() => setSuccessPunch(null)}
                className="rounded-2xl border border-stone-200 p-2 text-slate-500 transition hover:bg-stone-50 hover:text-slate-900"
                aria-label="Close attendance success modal"
              >
                <X className="h-4 w-4" />
              </button>
            </div>

            <div className="mt-4 grid gap-2 text-sm text-slate-700">
              <p><span className="font-medium">Employee:</span> {successPunch.employeeName}</p>
              <p><span className="font-medium">Code:</span> {successPunch.employeeCode}</p>
              <p><span className="font-medium">Device:</span> {successPunch.deviceName}</p>
              <p><span className="font-medium">Time:</span> {formatDateTime(successPunch.occurredAt)}</p>
            </div>
          </div>
        </div>
      ) : null}

      <div className="grid gap-6 xl:grid-cols-[0.9fr_1.1fr]">
      <section className="rounded-[28px] border border-stone-200 bg-white p-5 shadow-sm">
        <div className="flex items-center gap-3 border-b border-stone-200 pb-4">
          <div className="rounded-2xl bg-teal-100 p-3 text-teal-700">
            <Router className="h-5 w-5" />
          </div>
          <div>
            <p className="text-xs uppercase tracking-[0.18em] text-teal-700">Connection status</p>
            <h3 className="mt-1 text-xl font-semibold tracking-tight text-slate-950">
              Device connection monitor
            </h3>
          </div>
        </div>

        <div className="mt-5 space-y-4">
          {data.devices.map((device) => (
            <article key={device.id} className="rounded-[24px] border border-stone-200 bg-stone-50/80 p-4">
              <div className="flex items-start justify-between gap-3">
                <div>
                  <p className="text-sm font-medium text-slate-950">{device.name}</p>
                  <p className="mt-1 text-xs uppercase tracking-[0.18em] text-slate-500">
                    {device.ipAddress}
                  </p>
                </div>
                <StatusBadge label={device.status} />
              </div>
              <div className="mt-4 grid gap-2 text-sm text-slate-600">
                <p>Location: {device.location || "Not set"}</p>
                <p>Last seen: {formatRelativeTime(device.lastSeenAt)}</p>
                <p>Last sync: {formatDateTime(device.lastSyncAt)}</p>
              </div>
            </article>
          ))}
        </div>
      </section>

      <section className="rounded-[28px] border border-stone-200 bg-white p-5 shadow-sm">
        <div className="flex items-center gap-3 border-b border-stone-200 pb-4">
          <div className="rounded-2xl bg-amber-100 p-3 text-amber-700">
            <Fingerprint className="h-5 w-5" />
          </div>
          <div>
            <p className="text-xs uppercase tracking-[0.18em] text-teal-700">Automatic live table</p>
            <h3 className="mt-1 text-xl font-semibold tracking-tight text-slate-950">
              Fingerprint punch stream
            </h3>
          </div>
        </div>

        <div className="mt-5">
          <PaginatedTable
            rows={data.recentPunches}
            pageSize={6}
            getKey={(punch) => punch.id}
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
                <th className="px-3 py-3">Device</th>
                <th className="px-3 py-3">Punched at</th>
              </tr>
            }
            emptyState={
              <tr>
                <td colSpan={10} className="px-3 py-10 text-center text-sm text-slate-500">
                  Waiting for the next fingerprint punch from the device.
                </td>
              </tr>
            }
            mobileEmptyState={
              <div className="rounded-[24px] border border-stone-200 bg-white px-4 py-8 text-center text-sm text-slate-500">
                Waiting for the next fingerprint punch from the device.
              </div>
            }
            renderRow={(punch) => (
              <>
                <td className="px-3 py-4 font-medium text-slate-950">{punch.employeeName}</td>
                <td className="px-3 py-4">{punch.employeeCode}</td>
                <td className="px-3 py-4">{punch.biometricUid}</td>
                <td className="px-3 py-4">{punch.deviceUid ?? "-"}</td>
                <td className="px-3 py-4">{punch.deviceRole ?? "-"}</td>
                <td className="px-3 py-4">{punch.deviceCardNo ?? "-"}</td>
                <td className="px-3 py-4">{punch.department || "-"}</td>
                <td className="px-3 py-4">{punch.designation || "-"}</td>
                <td className="px-3 py-4">
                  <div>
                    <p>{punch.deviceName}</p>
                    <p className="mt-1 text-xs text-slate-500">{punch.deviceIp || punch.deviceStatus}</p>
                  </div>
                </td>
                <td className="px-3 py-4">{formatDateTime(punch.occurredAt)}</td>
              </>
            )}
            renderMobileCard={(punch) => (
              <div className="space-y-3 text-sm text-slate-700">
                <div className="flex items-start justify-between gap-3">
                  <div>
                    <p className="font-medium text-slate-950">{punch.employeeName}</p>
                    <p className="mt-1 text-xs uppercase tracking-[0.15em] text-slate-500">
                      {punch.employeeCode}
                    </p>
                  </div>
                  <StatusBadge label={punch.deviceStatus} />
                </div>
                <div className="grid grid-cols-2 gap-2 text-xs text-slate-600">
                  <p>UID: {punch.biometricUid}</p>
                  <p>Device UID: {punch.deviceUid ?? "-"}</p>
                  <p>Role: {punch.deviceRole ?? "-"}</p>
                  <p>Card: {punch.deviceCardNo ?? "-"}</p>
                </div>
                <div className="rounded-2xl bg-stone-50 px-3 py-2 text-xs text-slate-600">
                  <p>Device: {punch.deviceName}</p>
                  <p className="mt-1">Time: {formatDateTime(punch.occurredAt)}</p>
                </div>
              </div>
            )}
          />
        </div>
      </section>
      </div>
    </>
  );
}