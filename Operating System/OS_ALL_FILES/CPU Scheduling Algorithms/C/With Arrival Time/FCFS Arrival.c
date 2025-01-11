#include <stdio.h>
#include <stdlib.h>

// Define a structure for processes
struct Process {
    int processID;       // Process ID
    int burstTime;       // Burst Time
    int arrivalTime;     // Arrival Time
    int waitingTime;     // Waiting Time
    int turnAroundTime;  // Turnaround Time
};

int main() {
    int i, n; // Number of processes
    int totalWaitingTime = 0, totalTurnAroundTime = 0;

    printf("FCFS Scheduling Algorithm\n");
    printf("Enter the number of processes: ");
    scanf("%d", &n);

    struct Process processes[n]; // Array to store process details

    // Input arrival and burst times for processes
    for (i = 0; i < n; i++) {
        processes[i].processID = i + 1; // Assign Process ID
        printf("Enter info for process %d\n",processes[i].processID);
        printf("Arrival time : ");
        scanf("%d", &processes[i].arrivalTime);
        printf("Burst time : ");
        scanf("%d", &processes[i].burstTime);
    }

    // Sort processes by arrival time (optional step, for FCFS to work correctly)
    struct Process temp;
    for (i = 0; i < n - 1; i++) {
        for (int j = i + 1; j < n; j++) {
            if (processes[i].arrivalTime > processes[j].arrivalTime) {
                temp = processes[i];
                processes[i] = processes[j];
                processes[j] = temp;
            }
        }
    }

    // Calculate waiting time and turnaround time for each process
    processes[0].waitingTime = 0; // First process has zero waiting time
    processes[0].turnAroundTime = processes[0].burstTime;

    totalTurnAroundTime += processes[0].turnAroundTime;

    for (i = 1; i < n; i++) {
        // Waiting time depends on the previous process's finish time and the arrival time of the current process
        if (processes[i].arrivalTime > processes[i-1].arrivalTime + processes[i-1].burstTime) {
            processes[i].waitingTime = 0; // If the process arrives after the previous one finishes, no waiting
        } else {
            processes[i].waitingTime = (processes[i-1].arrivalTime + processes[i-1].burstTime) - processes[i].arrivalTime;
        }

        processes[i].turnAroundTime = processes[i].waitingTime + processes[i].burstTime;

        totalWaitingTime += processes[i].waitingTime;
        totalTurnAroundTime += processes[i].turnAroundTime;
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
    printf("\nAverage Turnaround Time: %.2f", (float)totalTurnAroundTime / n);

    return 0;
}
