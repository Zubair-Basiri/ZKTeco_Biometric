import { FeedbackModal } from "@/components/feedback-modal";
import { LiveDeviceFeed } from "@/components/live-device-feed";
import { SectionCard } from "@/components/section-card";
import { StatusBadge } from "@/components/status-badge";
import { SubmitButton } from "@/components/submit-button";
import {
  checkDeviceAction,
  createDeviceAction,
  syncDeviceUsersAction,
} from "@/app/actions";
import { formatDateTime, formatRelativeTime, readFeedback } from "@/lib/helpers";
import { getDevicesPageData, getLiveDeviceFeed, type DevicesPageData } from "@/lib/queries";

export const dynamic = "force-dynamic";

type PageProps = {
  searchParams?: Promise<Record<string, string | string[] | undefined>>;
};

const inputClassName =
  "w-full rounded-2xl border border-stone-300 bg-white px-4 py-3 text-sm text-slate-900 outline-none transition placeholder:text-slate-400 focus:border-teal-500";

export default async function DevicesPage({ searchParams }: PageProps) {
  const [data, liveFeed, feedback]: [DevicesPageData, Awaited<ReturnType<typeof getLiveDeviceFeed>>, Awaited<ReturnType<typeof readFeedback>>] = await Promise.all([
    getDevicesPageData(),
    getLiveDeviceFeed(),
    readFeedback(searchParams),
  ]);

  return (
    <div className="space-y-8">
      

      <FeedbackModal feedback={feedback} />

      <SectionCard
        eyebrow="New device"
        title="Register a biometric terminal"
           >
        <form action={createDeviceAction} className="grid gap-4 lg:grid-cols-2">
          <label className="grid gap-2 text-sm text-slate-700">
            <span>Device name</span>
            <input name="name" className={inputClassName} defaultValue="Main Entrance ZKTeco" required />
          </label>
          <label className="grid gap-2 text-sm text-slate-700">
            <span>IP address</span>
            <input name="ipAddress" className={inputClassName} defaultValue="192.168.1.201" required />
          </label>
          <label className="grid gap-2 text-sm text-slate-700">
            <span>Port</span>
            <input name="port" type="number" className={inputClassName} defaultValue="4370" required />
          </label>
          <label className="grid gap-2 text-sm text-slate-700">
            <span>Comm key</span>
            <input name="commKey" type="number" className={inputClassName} defaultValue="0" required />
          </label>
          <label className="grid gap-2 text-sm text-slate-700 lg:col-span-2">
            <span>Location</span>
            <input name="location" className={inputClassName} placeholder="Reception, main gate, warehouse ..." />
          </label>
          <label className="grid gap-2 text-sm text-slate-700 lg:col-span-2">
            <span>Notes</span>
            <textarea
              name="notes"
              className={`${inputClassName} min-h-28 resize-y`}
              placeholder="Physical placement, access policy, or any other device-specific note."
            />
          </label>
          <div className="lg:col-span-2 flex justify-end">
            <SubmitButton pendingLabel="Registering device...">Save device</SubmitButton>
          </div>
        </form>
      </SectionCard>

      <SectionCard
        eyebrow="Control plane"
        title="Registered terminals"
          >
        <div className="grid gap-5 xl:grid-cols-2">
          {data.devices.map((device: DevicesPageData["devices"][number]) => (
            <article key={device.id} className="rounded-[28px] border border-stone-200 bg-white p-5 shadow-sm">
              <div className="flex items-start justify-between gap-4">
                <div>
                  <p className="text-lg font-medium text-slate-950">{device.name}</p>
                  <p className="mt-1 text-xs uppercase tracking-[0.18em] text-slate-500">
                    {device.ipAddress}:{device.port}
                  </p>
                </div>
                <StatusBadge label={device.status} />
              </div>

              <dl className="mt-5 grid gap-3 text-sm text-slate-600">
                <div className="flex justify-between gap-4">
                  <dt>Location</dt>
                  <dd>{device.location || "Not set"}</dd>
                </div>
                <div className="flex justify-between gap-4">
                  <dt>Comm key</dt>
                  <dd>{device.commKey}</dd>
                </div>
                <div className="flex justify-between gap-4">
                  <dt>Last seen</dt>
                  <dd>{formatRelativeTime(device.lastSeenAt)}</dd>
                </div>
                <div className="flex justify-between gap-4">
                  <dt>Last sync</dt>
                  <dd>{formatDateTime(device.lastSyncAt)}</dd>
                </div>
                <div className="flex justify-between gap-4">
                  <dt>Attendance records</dt>
                  <dd>{device.attendanceCount}</dd>
                </div>
              </dl>

              {device.notes ? (
                <p className="mt-4 rounded-2xl bg-stone-50 px-4 py-3 text-sm text-slate-600">
                  {device.notes}
                </p>
              ) : null}

              <div className="mt-5 grid gap-3 md:grid-cols-2">
                <form action={checkDeviceAction}>
                  <input type="hidden" name="deviceId" value={device.id} />
                  <SubmitButton pendingLabel="Checking..." className="w-full bg-slate-950 text-stone-50">
                    Heartbeat
                  </SubmitButton>
                </form>
                <form action={syncDeviceUsersAction}>
                  <input type="hidden" name="deviceId" value={device.id} />
                  <SubmitButton
                    pendingLabel="Importing..."
                    className="w-full bg-teal-600 text-white hover:bg-teal-500"
                  >
                    Sync users
                  </SubmitButton>
                </form>
              </div>
            </article>
          ))}
        </div>
      </SectionCard>

      <SectionCard
        eyebrow="Automatic browser view"
        title="Live fingerprint table"
        description="When a user places a finger on the device, the portal records the event and refreshes this table automatically in the browser."
      >
        <LiveDeviceFeed initialData={liveFeed} />
      </SectionCard>
    </div>
  );
}
