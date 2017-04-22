defmodule Cron.SchedulerTest do
  use ExUnit.Case, async: true



  test "schedules a job" do
    Cron.Scheduler.schedule_single(%{name: :test, rate: 10})
    assert_receive :test
  end

  test "batch schedules jobs" do
    jobs = [
      %{ name: :test_1, rate: 10 },
      %{ name: :test_2, rate: 10 },
      %{ name: :test_3, rate: 10 },
    ]

    Cron.Scheduler.schedule_all(jobs)
    assert_receive :test_1
    assert_receive :test_2
    assert_receive :test_3

  end


  test "runs a job" do
     job = %{name: "", job: { Enum, :sum, [[1,2]] } }

     assert 3 == Cron.Scheduler.execute(job)
  end

end
