Vim�UnDo� ���0�(��`�1�>YU@"Ǡ�F<E�	�x�                                      bD
     _�                              ����                                                                                                                                                                                                                                                                                                                                                             bD
     �                  Iuse criterion::{criterion_group, criterion_main, BenchmarkId, Criterion};   Muse implementor::basics::criterion_example::{fibonacci_fast, fibonacci_slow};       /pub fn criterion_benchmark(c: &mut Criterion) {   3    let mut group = c.benchmark_group("Finonacci");   $    for i in [20u64, 21u64].iter() {   >        group.throughput(criterion::Throughput::Elements(*i));           group.bench_with_input(   2            BenchmarkId::new("fibonacci_slow", i),               i,   1            |b, i| b.iter(|| fibonacci_slow(*i)),   
        );           group.bench_with_input(   2            BenchmarkId::new("fibonacci_fast", i),               i,   1            |b, i| b.iter(|| fibonacci_fast(*i)),   
        );       }       group.finish();   }       /criterion_group!(benches, criterion_benchmark);   criterion_main!(benches);5�5��