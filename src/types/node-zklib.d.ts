declare module "node-zklib" {
  export type ZKUser = {
    uid: number;
    role: number;
    name?: string;
    userId?: string;
    cardno?: number;
  };

  export type ZKAttendance = {
    userId?: string;
    userSn?: number;
    deviceUserId?: number | string;
    recordTime: Date;
  };

  export type ZKInfo = {
    userCounts: number;
    logCounts: number;
    logCapacity: number;
  };

  export default class ZKLib {
    constructor(
      ip: string,
      port?: number,
      timeout?: number,
      inport?: number,
      commCode?: number,
      protocol?: "tcp" | "udp",
    );

    createSocket(
      cbErr?: (error: unknown) => void,
      cbClose?: () => void,
    ): Promise<unknown>;
    disconnect(): Promise<void>;
    getInfo(): Promise<ZKInfo>;
    getUsers(): Promise<{ data: ZKUser[]; err: unknown }>;
    getAttendances(
      callbackInProcess?: (received: number, total: number) => void,
    ): Promise<{ data: ZKAttendance[]; err: unknown }>;
    getTime?(): Promise<Date>;
    getRealTimeLogs(callback: (record: unknown) => void): Promise<void>;
  }
}