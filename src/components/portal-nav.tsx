"use client";

import Link from "next/link";
import { usePathname } from "next/navigation";
import { clsx } from "clsx";
import { Fingerprint, Router } from "lucide-react";

const items = [
  {
    href: "/employees",
    label: "Employees",
    icon: Fingerprint,
  },
  {
    href: "/devices",
    label: "Devices",
    icon: Router,
  },
];

export function PortalNav() {
  const pathname = usePathname();

  return (
    <nav className="space-y-2">
      {items.map((item) => {
        const Icon = item.icon;
        const active = pathname === item.href;

        return (
          <Link
            key={item.href}
            href={item.href}
            className={clsx(
              "flex items-center gap-3 rounded-2xl border px-4 py-3 text-sm transition",
              active
                ? "border-slate-900 bg-slate-900 text-stone-50 shadow-lg shadow-slate-900/10"
                : "border-stone-200 bg-white/80 text-slate-700 hover:border-teal-300 hover:bg-teal-50",
            )}
          >
            <Icon className="h-4 w-4" />
            <span>{item.label}</span>
          </Link>
        );
      })}
    </nav>
  );
}
