#include <stdio.h>

#define MAX_PROCESSES 10

// Define a structure to represent a process
struct Process {
    int processID;         // Process ID
    int arrivalTime;       // Arrival Time
    int burstTime;         // Burst Time
    int remainingTime;     // Remaining Burst Time
    int completionTime;    // Completion Time
    int turnAroundTime;    // Turnaround Time
    int waitingTime;       // Waiting Time
};

// Function to calculate Round Robin Scheduling
void roundRobin(struct Process processes[], int n, int quantum) {
    int time = 0; // Start time
    int completed = 0; // Count of completed processes
    int executionSequence[MAX_PROCESSES]; // Array to store the execution sequence
    int seqIndex = 0; // Index for execution sequence

    // Round Robin scheduling
    while (completed < n) {
        for (int i = 0; i < n; i++) {
            // If the process has arrived and has remaining burst time
            if (processes[i].arrivalTime <= time && processes[i].remainingTime > 0) {
                executionSequence[seqIndex++] = processes[i].processID; // Store the process ID in execution sequence

                if (processes[i].remainingTime <= quantum) {
                    time += processes[i].remainingTime;
                    processes[i].remainingTime = 0;
                    processes[i].completionTime = time;
                    completed++;
                } else {
                    time += quantum;
                    processes[i].remainingTime -= quantum;
                }
            }
        }
    }

    // Calculate Turnaround Time and Waiting Time for each process
    for (int i = 0; i < n; i++) {
        processes[i].turnAroundTime = processes[i].completionTime - processes[i].arrivalTime;
        processes[i].waitingTime = processes[i].turnAroundTime - processes[i].burstTime;
    }

    // Display Execution Sequence
    printf("\nProcess Execution Sequence: ");
    for (int i = 0; i < seqIndex; i++) {
        printf("P%d", executionSequence[i]);
        if (i < seqIndex - 1) {
            printf(" -> ");
        }
    }
    printf("\n");
}

// Function to display the results in a tabular format
void displayResults(struct Process processes[], int n) {
    int totalWaitingTime = 0, totalTurnAroundTime = 0;

    printf("\nProcess_ID\tArrival_Time\tBurst_Time\tCompletion_Time\tTurnaround_Time\tWaiting_Time\n");
    for (int i = 0; i < n; i++) {
        totalWaitingTime += processes[i].waitingTime;
        totalTurnAroundTime += processes[i].turnAroundTime;

        printf("%d\t\t%d\t\t%d\t\t%d\t\t%d\t\t%d\n",
               processes[i].processID,
               processes[i].arrivalTime,
               processes[i].burstTime,
               processes[i].completionTime,
               processes[i].turnAroundTime,
               processes[i].waitingTime);
    }

    // Calculate and display total and average times
    printf("\nTotal Waiting Time: %d", totalWaitingTime);
    printf("\nAverage Waiting Time: %.2f", (float)totalWaitingTime / n);
    printf("\nTotal Turnaround Time: %d", totalTurnAroundTime);
    printf("\nAverage Turnaround Time: %.2f\n", (float)totalTurnAroundTime / n);
}

int main() {
    int n, quantum;

    // Input the number of processes and quantum time
    printf("Enter the number of processes: ");
    scanf("%d", &n);

    printf("Enter the quantum time: ");
    scanf("%d", &quantum);

    struct Process processes[MAX_PROCESSES];

    // Input the process details
    for (int i = 0; i < n; i++) {
        printf("\nEnter details for Process %d\n", i + 1);
        processes[i].processID = i + 1;
        printf("Arrival Time: ");
        scanf("%d", &processes[i].arrivalTime);
        printf("Burst Time: ");
        scanf("%d", &processes[i].burstTime);
        processes[i].remainingTime = processes[i].burstTime; // Initialize remaining time as burst time
    }

    // Apply Round Robin Scheduling
    roundRobin(processes, n, quantum);

    // Display the results
    displayResults(processes, n);

    return 0;
}
