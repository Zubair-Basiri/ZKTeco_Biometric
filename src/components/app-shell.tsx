import type { ReactNode } from "react";
import { ActivitySquare, ShieldCheck } from "lucide-react";
import { PortalNav } from "@/components/portal-nav";

export function AppShell({ children }: { children: ReactNode }) {
  return (
    <div className="relative min-h-screen">
      <div className="mx-auto flex min-h-screen max-w-[1600px] flex-col gap-6 px-4 py-4 lg:flex-row lg:px-6 lg:py-6">
        <aside className="w-full rounded-[28px] border border-stone-200/80 bg-stone-50/90 p-5 shadow-[0_24px_80px_rgba(15,23,32,0.08)] backdrop-blur lg:sticky lg:top-6 lg:h-[calc(100vh-3rem)] lg:w-[292px]">
          <div className="flex items-start justify-between gap-4 border-b border-stone-200 pb-5">
            <div>
              <p className="text-xs uppercase tracking-[0.24em] text-teal-700">ZKTeco</p>
              <h1 className="mt-2 text-2xl font-semibold tracking-tight text-slate-950">
                Workforce Portal
              </h1>
             
            </div>
            <div className="rounded-2xl bg-teal-600/10 p-3 text-teal-700">
              <ActivitySquare className="h-5 w-5" />
            </div>
          </div>

          <div className="mt-5">
            <PortalNav />
          </div>

          
        </aside>

        <main className="min-w-0 flex-1 rounded-[32px] border border-stone-200/70 bg-white/90 p-5 shadow-[0_24px_80px_rgba(15,23,32,0.06)] backdrop-blur lg:p-8">
          {children}
        </main>
      </div>
    </div>
  );
}
