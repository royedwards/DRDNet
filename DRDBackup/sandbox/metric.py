from vboxapi import * 
mgr = VirtualBoxManager(None, None)
vbox = mgr.vbox
# Enabling performance collection
perfomance_collector = self.vbox.performanceCollector
# Enable metrics (None = all metrics, None = all machines)
perfomance_collector.enableMetrics(None, None)
# Setup metrics (None = all metrics, None = all machines, 1 sample every second, keep up to 15 samples)
perfomance_collector.setupMetrics(None, None, 1, 15)

while True:
    # get metrics
    (values, names_out, objects_out, units, scales, sequence_numbers, indices, lengths) = perfomance_collector.queryMetricsData(None, None)
    out = []
    # process results
    for i in range(0, len(names_out)):
        scale = int(scales[i])
        if scale != 1:
            fmt = '%.2f%s'
        else:
            fmt = '%d %s'
        out.append({
            'name': str(names_out[i]),
            'object': str(objects_out[i]),
            'unit': str(units[i]),
            'scale': scale,
            'values': [int(values[j]) for j in range(int(indices[i]), int(indices[i]) + int(lengths[i]))],
            'values_as_string': '[' + ', '.join([fmt % (int(values[j]) / scale, units[i]) for j in range(int(indices[i]), int(indices[i]) + int(lengths[i]))]) + ']'
        })
    # print something useful
    for metric in out:
        print(metric['name'], metric['values_as_string'])
    time.sleep(5)

