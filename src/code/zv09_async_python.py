import asyncio


async def worker(name, seconds):
    print(f"{name} indul")
    await asyncio.sleep(seconds)
    print(f"{name} kesz")
    return name


async def main():
    task_a = asyncio.create_task(worker("A", 2))
    task_b = asyncio.create_task(worker("B", 1))
    task_c = asyncio.create_task(worker("C", 3))
    results = await asyncio.gather(task_a, task_b, task_c)
    print(results)


asyncio.run(main())
