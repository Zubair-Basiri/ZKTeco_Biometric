import { clsx } from "clsx";

type StatusBadgeProps = {
  label: string;
};

export function StatusBadge({ label }: StatusBadgeProps) {
  const normalized = label.toUpperCase();

  return (
    <span
      className={clsx(
        "inline-flex items-center rounded-full px-3 py-1 text-xs font-medium tracking-[0.16em] uppercase",
        normalized === "ONLINE" || normalized === "SUCCESS"
          ? "bg-emerald-100 text-emerald-700"
          : normalized === "RUNNING"
            ? "bg-sky-100 text-sky-700"
            : normalized === "OFFLINE" || normalized === "FAILED" || normalized === "ERROR"
              ? "bg-rose-100 text-rose-700"
              : "bg-stone-200 text-slate-700",
      )}
    >
      {label}
    </span>
  );
}
