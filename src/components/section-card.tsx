import type { ReactNode } from "react";

type SectionCardProps = {
  eyebrow?: string;
  title: string;
  description?: string;
  actions?: ReactNode;
  children: ReactNode;
};

export function SectionCard({
  eyebrow,
  title,
  description,
  actions,
  children,
}: SectionCardProps) {
  return (
    <section className="rounded-[28px] border border-stone-200 bg-stone-50/70 p-5 shadow-sm lg:p-6">
      <div className="flex flex-col gap-4 border-b border-stone-200 pb-4 md:flex-row md:items-end md:justify-between">
        <div>
          {eyebrow ? (
            <p className="text-xs uppercase tracking-[0.24em] text-teal-700">{eyebrow}</p>
          ) : null}
          <h2 className="mt-2 text-2xl font-semibold tracking-tight text-slate-950">{title}</h2>
          {description ? (
            <p className="mt-2 max-w-2xl text-sm leading-6 text-slate-600">{description}</p>
          ) : null}
        </div>
        {actions ? <div className="flex flex-wrap gap-3">{actions}</div> : null}
      </div>
      <div className="mt-5">{children}</div>
    </section>
  );
}
