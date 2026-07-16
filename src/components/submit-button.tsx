"use client";

import type { ReactNode } from "react";
import { clsx } from "clsx";
import { useFormStatus } from "react-dom";

type SubmitButtonProps = {
  children: ReactNode;
  pendingLabel?: string;
  className?: string;
};

export function SubmitButton({
  children,
  pendingLabel = "Working...",
  className,
}: SubmitButtonProps) {
  const { pending } = useFormStatus();

  return (
    <button
      type="submit"
      disabled={pending}
      className={clsx(
        "inline-flex items-center justify-center rounded-2xl bg-slate-950 px-4 py-2.5 text-sm font-medium text-stone-50 transition hover:bg-slate-800 disabled:cursor-not-allowed disabled:opacity-60",
        className,
      )}
    >
      {pending ? pendingLabel : children}
    </button>
  );
}
