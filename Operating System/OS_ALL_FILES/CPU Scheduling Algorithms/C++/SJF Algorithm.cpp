#include <bits/stdc++.h>
#define ll long long
#define pb push_back
using namespace std;

// Define a Process structure
struct Process
{
    int id;          // Process ID
    int arrivalTime; // Arrival Time
    int burstTime;   // Burst Time
    int completionTime;
    int turnAroundTime;
    int waitingTime;
};

int main()
{
    int n; // Number of processes
    cout << "Enter the number of processes: ";
    cin >> n;

    vector<Process> processes(n);
    cout << "Enter Process_ID, Arrival_Time, and Burst_Time for each process:\n";
    for (int i = 0; i < n; i++)
    {
        cin >> processes[i].id >> processes[i].arrivalTime >> processes[i].burstTime;
    }

    // Sort processes based on arrival time
    sort(processes.begin(), processes.end(), [](Process &a, Process &b)
         { return a.arrivalTime < b.arrivalTime; });

    int currentTime = 0;
    vector<bool> isCompleted(n, false); // To keep track of completed processes
    int completed = 0;

    while (completed < n)
    {
        int idx = -1; // Index of the process to execute next
        int minBurst = INT_MAX;

        // Select process with shortest burst time among the arrived processes
        for (int i = 0; i < n; i++)
        {
            if (!isCompleted[i] && processes[i].arrivalTime <= currentTime)
            {
                if (processes[i].burstTime < minBurst)
                {
                    minBurst = processes[i].burstTime;
                    idx = i;
                }
                // Break ties by process ID (optional for consistent ordering)
                else if (processes[i].burstTime == minBurst && processes[i].id < processes[idx].id)
                {
                    idx = i;
                }
            }
        }

        if (idx != -1)
        {
            // Execute the selected process
            currentTime += processes[idx].burstTime;
            processes[idx].completionTime = currentTime;
            processes[idx].turnAroundTime = processes[idx].completionTime - processes[idx].arrivalTime;
            processes[idx].waitingTime = processes[idx].turnAroundTime - processes[idx].burstTime;

            isCompleted[idx] = true; // Mark process as completed
            completed++;
        }
        else
        {
            // If no process has arrived, increment time
            currentTime++;
        }
    }

    // Output the results in table format
    cout << "\nProcess_ID\tArrival_Time\tBurst_Time\tCompletion_Time\tTurn_Around_Time\tWaiting_Time\n";
    for (const auto &p : processes)
    {
        cout << p.id << "\t\t" << p.arrivalTime << "\t\t" << p.burstTime
             << "\t\t" << p.completionTime << "\t\t" << p.turnAroundTime
             << "\t\t" << p.waitingTime << "\n";
    }

    return 0;
}
