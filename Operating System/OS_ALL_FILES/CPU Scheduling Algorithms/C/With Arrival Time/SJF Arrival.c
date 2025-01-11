#include <stdio.h>
#include <stdlib.h>

// Define a structure to represent a process
typedef struct {
    int processID;       // Process ID
    int burstTime;       // Burst Time
    int arrivalTime;     // Arrival Time
    int waitingTime;     // Waiting Time
    int turnAroundTime;  // Turnaround Time
} Process;

int main() {
    int i, j, n;
    int totalWaitingTime = 0, totalTurnAroundTime = 0;
    Process *processes, temp;

    printf("\nSJF Scheduling Algorithm\n");
    printf("Enter the number of processes: ");
    scanf("%d", &n);

    // Allocate memory for processes
    processes = (Process *)malloc(n * sizeof(Process));

    // Input arrival and burst times for processes
    printf("\nEnter the arrival and burst times:\n");
    for (i = 0; i < n; i++) {
        printf("Process %d\n", i + 1);
        printf("Arrival Time: ");
        scanf("%d", &processes[i].arrivalTime);
        printf("Burst Time: ");
        scanf("%d", &processes[i].burstTime);
        processes[i].processID = i + 1;
        processes[i].waitingTime = 0; // Initialize waiting time
        processes[i].turnAroundTime = 0; // Initialize turnaround time
    }

    // Sort processes by arrival time first, then by burst time
    for (i = 0; i < n - 1; i++) {
        for (j = i + 1; j < n; j++) {
            if (processes[i].arrivalTime > processes[j].arrivalTime || 
               (processes[i].arrivalTime == processes[j].arrivalTime && processes[i].burstTime > processes[j].burstTime)) {
                temp = processes[i];
                processes[i] = processes[j];
                processes[j] = temp;
            }
        }
    }

    // Execute processes using SJF (Shortest Job First) scheduling
    int currentTime = 0;  // Track the time elapsed during execution
    int completed = 0;
    int completedFlag[n];  // Array to track which processes have been completed
    for (i = 0; i < n; i++) {
        completedFlag[i] = 0; // Initially, all processes are not completed
    }

    while (completed < n) {
        int idx = -1;
        int minBurstTime = 10000; // Arbitrarily large value

        // Find the process with the shortest burst time that has arrived
        for (i = 0; i < n; i++) {
            if (processes[i].arrivalTime <= currentTime && !completedFlag[i]) {
                if (processes[i].burstTime < minBurstTime) {
                    minBurstTime = processes[i].burstTime;
                    idx = i;
                }
            }
        }

        if (idx != -1) {
            printf("currt time : %d\n",currentTime);
            printf("proces id : %d\n",processes[idx].processID);
            // Calculate waiting time and turnaround time for the selected process
            currentTime += processes[idx].burstTime;
            printf("comple time : %d\n",currentTime);
            processes[idx].turnAroundTime = currentTime-processes[idx].burstTime;
            processes[idx].waitingTime = processes[idx].turnAroundTime - processes[idx].arrivalTime;

            /* processes[idx].waitingTime = currentTime - processes[idx].arrivalTime;
            processes[idx].turnAroundTime = processes[idx].waitingTime + processes[idx].burstTime; */
            totalWaitingTime += processes[idx].waitingTime;
            totalTurnAroundTime += processes[idx].turnAroundTime;
            //currentTime += processes[idx].burstTime;
            completedFlag[idx] = 1;  // Mark process as completed
            completed++;
        } else {
            currentTime++; // No process ready to execute, increment time (CPU is idle)
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

    // Output the results in a tabular format
    printf("\n\nProcess_ID\tArrival_Time\tBurst_Time\tWaiting_Time\tTurnaround_Time\n");
    for (i = 0; i < n; i++) {
        printf("%d\t\t%d\t\t%d\t\t%d\t\t%d\n",
               processes[i].processID,
               processes[i].arrivalTime,
               processes[i].burstTime,
               processes[i].waitingTime,
               processes[i].turnAroundTime);
    }

    // Print total and average times
    printf("\nTotal Waiting Time: %d", totalWaitingTime);
    printf("\nAverage Waiting Time: %.2f", (float)totalWaitingTime / n);
    printf("\nTotal Turnaround Time: %d", totalTurnAroundTime);
    printf("\nAverage Turnaround Time: %.2f\n", (float)totalTurnAroundTime / n);

    // Free allocated memory
    free(processes);

    return 0;
}
