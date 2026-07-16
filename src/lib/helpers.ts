import { format, formatDistanceToNow } from "date-fns";

export type AppSearchParams = Promise<
  Record<string, string | string[] | undefined>
>;

function firstValue(value: string | string[] | undefined) {
  return Array.isArray(value) ? value[0] : value;
}

export async function readFeedback(searchParams?: AppSearchParams) {
  if (!searchParams) {
    return null;
  }

  const params = await searchParams;
  const message = firstValue(params.message);
  const type = firstValue(params.type);

  if (!message || !type) {
    return null;
  }

  return {
    message,
    type: type === "error" ? "error" : "success",
  } as const;
}

export function sanitizeCode(value: string) {
  return value
    .trim()
    .replace(/[^a-zA-Z0-9_-]+/g, "-")
    .replace(/-{2,}/g, "-")
    .replace(/^[-_]+|[-_]+$/g, "")
    .toUpperCase();
}

export function splitFullName(name: string) {
  const cleaned = name.trim().replace(/\s+/g, " ");
  const [firstName, ...rest] = cleaned.split(" ");

  return {
    firstName: firstName || "Device",
    lastName: rest.join(" ") || "Employee",
  };
}

export function getEmployeeName(employee?: {
  firstName: string;
  lastName: string;
} | null) {
  if (!employee) {
    return "Unassigned";
  }

  return `${employee.firstName} ${employee.lastName}`.trim();
}

export function formatDateTime(value?: Date | string | null) {
  if (!value) {
    return "Never";
  }

  const date = typeof value === "string" ? new Date(value) : value;

  if (Number.isNaN(date.getTime())) {
    return "Invalid date";
  }

  return format(date, "dd MMM yyyy, hh:mm a");
}

export function formatDateOnly(value?: Date | string | null) {
  if (!value) {
    return "-";
  }

  const date = typeof value === "string" ? new Date(value) : value;
  return format(date, "dd MMM yyyy");
}

export function formatTimeOnly(value?: Date | string | null) {
  if (!value) {
    return "-";
  }

  const date = typeof value === "string" ? new Date(value) : value;
  return format(date, "hh:mm a");
}

export function formatRelativeTime(value?: Date | string | null) {
  if (!value) {
    return "No recent heartbeat";
  }

  const date = typeof value === "string" ? new Date(value) : value;
  return `${formatDistanceToNow(date, { addSuffix: true })}`;
}

export function toDateTimeInputValue(value = new Date()) {
  return format(value, "yyyy-MM-dd'T'HH:mm");
}

export function getErrorMessage(error: unknown) {
  if (error instanceof Error) {
    return error.message;
  }

  if (typeof error === "string") {
    return error;
  }

  return "Unexpected error";
}
