"use client";

import { useState } from "react";
import { CheckCircle2, CircleAlert, X } from "lucide-react";
import { usePathname, useRouter, useSearchParams } from "next/navigation";

type FeedbackModalProps = {
  feedback: {
    type: "success" | "error";
    message: string;
  } | null;
};

export function FeedbackModal({ feedback }: FeedbackModalProps) {
  const [open, setOpen] = useState(Boolean(feedback));
  const pathname = usePathname();
  const router = useRouter();
  const searchParams = useSearchParams();

  if (!feedback || !open) {
    return null;
  }

  const isSuccess = feedback.type === "success";

  function handleClose() {
    const nextParams = new URLSearchParams(searchParams.toString());
    nextParams.delete("type");
    nextParams.delete("message");

    const nextQuery = nextParams.toString();
    router.replace(nextQuery ? `${pathname}?${nextQuery}` : pathname, { scroll: false });
    setOpen(false);
  }

  return (
    <div className="fixed inset-0 z-50 flex items-center justify-center bg-slate-950/40 px-4 py-6 backdrop-blur-sm">
      <div className="w-full max-w-md rounded-[28px] border border-stone-200 bg-white p-6 shadow-[0_28px_90px_rgba(15,23,32,0.18)]">
        <div className="flex items-start justify-between gap-4">
          <div className="flex items-start gap-3">
            <div
              className={
                isSuccess
                  ? "rounded-2xl bg-emerald-100 p-3 text-emerald-700"
                  : "rounded-2xl bg-rose-100 p-3 text-rose-700"
              }
            >
              {isSuccess ? <CheckCircle2 className="h-5 w-5" /> : <CircleAlert className="h-5 w-5" />}
            </div>
            <div>
              <p className="text-xs uppercase tracking-[0.18em] text-slate-500">
                {isSuccess ? "Success" : "Problem detected"}
              </p>
              <h2 className="mt-1 text-xl font-semibold tracking-tight text-slate-950">
                {isSuccess ? "Action completed" : "Action failed"}
              </h2>
            </div>
          </div>
          <button
            type="button"
            onClick={handleClose}
            className="rounded-2xl border border-stone-200 p-2 text-slate-500 transition hover:bg-stone-50 hover:text-slate-900"
            aria-label="Close feedback modal"
          >
            <X className="h-4 w-4" />
          </button>
        </div>

        <p className="mt-5 text-sm leading-7 text-slate-600">{feedback.message}</p>

        <div className="mt-6 flex justify-end">
          <button
            type="button"
            onClick={handleClose}
            className={
              isSuccess
                ? "rounded-2xl bg-emerald-600 px-4 py-2.5 text-sm font-medium text-white transition hover:bg-emerald-500"
                : "rounded-2xl bg-rose-600 px-4 py-2.5 text-sm font-medium text-white transition hover:bg-rose-500"
            }
          >
            Close
          </button>
        </div>
      </div>
    </div>
  );
}
