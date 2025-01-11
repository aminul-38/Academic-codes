#include <stdio.h>
#include <stdlib.h>

// Define a structure to represent a process
typedef struct {
    int processID;       // Process ID
    int priority;        // Priority
    int burstTime;       // Burst Time
    int waitingTime;     // Waiting Time
} Process;

int main() {
    int i, j, numProcesses;
    int totalBurstTime = 0, totalWaitingTime = 0, totalTurnAroundTime = 0;
    Process *processes, temp;

    printf("\nPriority Scheduling Algorithm\n");
    printf("Enter the number of processes: ");
    scanf("%d", &numProcesses);

    // Allocate memory for the processes
    processes = (Process *)malloc(numProcesses * sizeof(Process));

    // Input burst times and priorities for processes
    printf("Enter the burst time and priority for each process:\n");
    for (i = 0; i < numProcesses; i++) {
        printf("Process %d:\n", i + 1);
        printf("Burst Time: ");
        scanf("%d", &processes[i].burstTime);
        printf("Priority: ");
        scanf("%d", &processes[i].priority);
        processes[i].processID = i + 1;
        processes[i].waitingTime = 0; // Initialize waiting time
    }

    // Sort processes by priority (ascending order)
    for (i = 0; i < numProcesses - 1; i++) {
        for (j = i + 1; j < numProcesses; j++) {
            if (processes[i].priority > processes[j].priority) {
                temp = processes[i];
                processes[i] = processes[j];
                processes[j] = temp;
            }
        }
    }

    // Output the process execution sequence
    printf("\nProcess Execution Sequence: ");
    for (i = 0; i < numProcesses; i++) {
        printf("P%d", processes[i].processID);
        if (i < numProcesses - 1) {
            printf(" -> ");
        }
    }

    // Calculate waiting time and turnaround time
    printf("\n\nProcess_ID\tPriority\tBurst_Time\tWaiting_Time\tTurnaround_Time\n");
    for (i = 0; i < numProcesses; i++) {
        totalWaitingTime += processes[i].waitingTime;
        totalBurstTime += processes[i].burstTime;

        printf("%d\t\t%d\t\t%d\t\t%d\t\t%d\n",
               processes[i].processID,
               processes[i].priority,
               processes[i].burstTime,
               processes[i].waitingTime,
               processes[i].waitingTime + processes[i].burstTime);

        if (i < numProcesses - 1) {
            processes[i + 1].waitingTime = totalBurstTime;
        }
    }

    // Calculate total turnaround time
    totalTurnAroundTime = totalBurstTime + totalWaitingTime;

    // Print total and average times
    printf("\nTotal Waiting Time: %d", totalWaitingTime);
    printf("\nAverage Waiting Time: %.2f", (float)totalWaitingTime / numProcesses);
    printf("\nTotal Turnaround Time: %d", totalTurnAroundTime);
    printf("\nAverage Turnaround Time: %.2f\n", (float)totalTurnAroundTime / numProcesses);

    // Free allocated memory
    free(processes);

    return 0;
}
