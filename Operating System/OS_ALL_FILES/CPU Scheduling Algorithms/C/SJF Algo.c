#include <stdio.h>
#include <stdlib.h>

// Define a structure to represent a process
typedef struct {
    int processID;       // Process ID
    int burstTime;       // Burst Time
    int waitingTime;     // Waiting Time
} Process;

int main() {
    int i, j, n;
    int totalBurstTime = 0, totalWaitingTime = 0, totalTurnAroundTime;
    Process *processes, temp;

    printf("\nSJF Scheduling Algorithm\n");
    printf("Enter the number of processes: ");
    scanf("%d", &n);

    // Allocate memory for processes
    processes = (Process *)malloc(n * sizeof(Process));

    // Input burst times for processes
    printf("\nEnter the burst times:\n");
    for (i = 0; i < n; i++) {
        printf("Process %d: ", i + 1);
        scanf("%d", &processes[i].burstTime);
        processes[i].processID = i + 1;
        processes[i].waitingTime = 0; // Initialize waiting time
    }

    // Sort processes by burst time (ascending order)
    for (i = 0; i < n - 1; i++) {
        for (j = i + 1; j < n; j++) {
            if (processes[i].burstTime > processes[j].burstTime) {
                temp = processes[i];
                processes[i] = processes[j];
                processes[j] = temp;
            }
        }
    }

    // Output the process execution sequence
    printf("\nProcess Execution Sequence: ");
    for (i = 0; i < n; i++) {
        printf("P%d", processes[i].processID);
        if (i < n - 1) {
            printf(" -> ");
        }
    }

    // Calculate waiting time and turnaround time
    printf("\n\nProcess_ID\tBurst_Time\tWaiting_Time\tTurnaround_Time\n");
    for (i = 0; i < n; i++) {
        totalWaitingTime += processes[i].waitingTime;
        totalBurstTime += processes[i].burstTime;

        printf("%d\t\t%d\t\t%d\t\t%d\n",
               processes[i].processID,
               processes[i].burstTime,
               processes[i].waitingTime,
               processes[i].waitingTime + processes[i].burstTime);

        if (i < n - 1) {
            processes[i + 1].waitingTime = totalBurstTime;
        }
    }

    // Calculate total turnaround time
    totalTurnAroundTime = totalBurstTime + totalWaitingTime;

    // Print total and average times
    printf("\nTotal Waiting Time: %d", totalWaitingTime);
    printf("\nAverage Waiting Time: %.2f", (float)totalWaitingTime / n);
    printf("\nTotal Turnaround Time: %d", totalTurnAroundTime);
    printf("\nAverage Turnaround Time: %.2f\n", (float)totalTurnAroundTime / n);

    // Free allocated memory
    free(processes);

    return 0;
}
