#include <stdio.h>
#include <stdlib.h>

// Define a structure to represent a process
typedef struct {
    int processID;        // Process ID
    int burstTime;        // Initial Burst Time
    int remainingTime;    // Remaining Burst Time
    int waitingTime;      // Waiting Time
    int lastServedTime;   // Last Time the Process was Executed
} Process;

int main() {
    int i, numProcesses, timeSlice, time = 0, flag, executedProcess = -1;
    int totalWaitingTime = 0, totalTurnAroundTime = 0;
    Process processes[10]; // Array to store processes

    printf("\nRound Robin Scheduling Algorithm\n");
    printf("Enter the number of processes: ");
    scanf("%d", &numProcesses);

    printf("Enter the time slice: ");
    scanf("%d", &timeSlice);

    // Input burst times for all processes
    printf("Enter the burst times for each process:\n");
    for (i = 0; i < numProcesses; i++) {
        printf("Process %d Burst Time: ", i + 1);
        scanf("%d", &processes[i].burstTime);
        processes[i].processID = i + 1;
        processes[i].remainingTime = processes[i].burstTime;
        processes[i].waitingTime = 0;
        processes[i].lastServedTime = 0;
    }

    printf("\nScheduling Processes...\n");
    printf("\nExecution Sequence: ");

    // Round Robin Scheduling Logic
    do {
        flag = 0; // To check if any process is left to execute

        for (i = 0; i < numProcesses; i++) {
            if (processes[i].remainingTime > 0) {
                flag = 1; // At least one process needs execution

                // Determine the execution time for the current process
                int executionTime = (processes[i].remainingTime >= timeSlice) ? timeSlice : processes[i].remainingTime;

                // Print the process execution details
                printf("P%d(%d-%d) ", processes[i].processID, time, time + executionTime);

                // Update time and process remaining time
                time += executionTime;
                processes[i].remainingTime -= executionTime;

                // Update waiting time if this is a new execution
                if (executedProcess != i) {
                    executedProcess = i;
                }
                processes[i].waitingTime += time - processes[i].lastServedTime - executionTime;
                processes[i].lastServedTime = time;
            }
        }
    } while (flag);

    // Output the process details
    printf("\n\nProcess_ID\tBurst_Time\tWaiting_Time\tTurnaround_Time\n");
    for (i = 0; i < numProcesses; i++) {
        int turnAroundTime = processes[i].burstTime + processes[i].waitingTime;
        totalWaitingTime += processes[i].waitingTime;
        totalTurnAroundTime += turnAroundTime;

        printf("%d\t\t%d\t\t%d\t\t%d\n",
               processes[i].processID,
               processes[i].burstTime,
               processes[i].waitingTime,
               turnAroundTime);
    }

    // Print total and average waiting and turnaround times
    printf("\nTotal Waiting Time: %d", totalWaitingTime);
    printf("\nAverage Waiting Time: %.2f", (float)totalWaitingTime / numProcesses);
    printf("\nTotal Turnaround Time: %d", totalTurnAroundTime);
    printf("\nAverage Turnaround Time: %.2f\n", (float)totalTurnAroundTime / numProcesses);

    return 0;
}
