void initAllocator();
void endAllocator();

void* allocBlk(int num_bytes);
int freeBlk(void* blk);

void printHeap();
